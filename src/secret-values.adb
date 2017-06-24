-----------------------------------------------------------------------
--  secret-values -- Ada wrapper for Secret Service
--  Copyright (C) 2017 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
-----------------------------------------------------------------------

package body Secret.Values is

   function Secret_Value_New (Sec  : in Chars_Ptr;
                              Len  : in Natural;
                              Kind : in Chars_Ptr) return Opaque_Type
     with Import => True, Convention => C, Link_Name => "secret_value_new";

   function Secret_Value_Ref (Value : in Opaque_Type) return Opaque_Type
     with Import => True, Convention => C, Link_Name => "secret_value_ref";

   procedure Secret_Value_Unref (Value : in Opaque_Type)
     with Import => True, Convention => C, Link_Name => "secret_value_unref";

   function Secret_Value_Get_Content_Type (Value : in Opaque_Type) return Chars_Ptr
     with Import => True, Convention => C, Link_Name => "secret_value_get_content_type";

   function Secret_Value_Get (Value : in Opaque_Type;
                              Length : in System.Address) return Chars_Ptr
     with Import => True, Convention => C, Link_Name => "secret_value_get";

   --  ------------------------------
   --  Create a value with the default content type text/plain.
   --  ------------------------------
   function Create (Value : in String) return Secret_Type is
      Sec  : Chars_Ptr := New_String (Value);
      Kind : Chars_Ptr := New_String ("text/plain");
   begin
      return Result : Secret_Type do
         Result.Opaque := Secret_Value_New (Sec, Value'Length, Kind);
         Free (Sec);
         Free (Kind);
      end return;
   end Create;

   --  ------------------------------
   --  Get the value content type.
   --  ------------------------------
   function Get_Content_Type (Value : in Secret_Type) return String is
      Ptr : constant Chars_Ptr := Secret_Value_Get_Content_Type (Value.Opaque);
   begin
      return To_String (Ptr);
   end Get_Content_Type;

   --  ------------------------------
   --  Get the value as a string.
   --  ------------------------------
   function Get_Value (Value : in Secret_Type) return String is
      Len : aliased Natural;
      Ptr : constant Chars_Ptr := Secret_Value_Get (Value.Opaque, Len'Address);
   begin
      return To_String (Ptr);
   end Get_Value;

   overriding
   procedure Adjust (Object : in out Secret_Type) is
   begin
      if Object.Opaque /= System.Null_Address then
         Object.Opaque := Secret_Value_Ref (Object.Opaque);
      end if;
   end Adjust;

   overriding
   procedure Finalize (Object : in out Secret_Type) is
   begin
      if Object.Opaque /= System.Null_Address then
         Secret_Value_Unref (Object.Opaque);
      end if;
   end Finalize;

end Secret.Values;
