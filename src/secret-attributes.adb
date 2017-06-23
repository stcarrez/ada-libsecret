-----------------------------------------------------------------------
--  secret-attributes -- Attribute list representation
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
package body Secret.Attributes is

   type Hash_Function is access function return Integer with Convention => C;

   function Str_Hash return Integer
     with Import => True, Convention => C, Link_Name => "g_str_hash";

   type Free_Func is access procedure with Convention => C;

   procedure Str_Free
     with Import => True, Convention => C, Link_Name => "g_free";

   type Compare_Function is access function return Integer with Convention => C;

   function Str_Compare return Integer
     with Import => True, Convention => C, Link_Name => "g_str_equal";

   function Hash_Table_New_Full (Hash : in Hash_Function;
                                 Comp : in Compare_Function;
                                 R1   : in Free_Func;
                                 R2   : in Free_Func) return Opaque_Type
     with Import => True, Convention => C, Link_Name => "g_hash_table_new_full";

   function Hash_Table_Ref (Object : in Opaque_Type) return Opaque_Type
     with Import => True, Convention => C, Link_Name => "g_hash_table_ref";

   procedure Hash_Table_Unref (Object : in Opaque_Type)
     with Import => True, Convention => C, Link_Name => "g_hash_table_unref";

   procedure Hash_Table_Insert (Object : in Opaque_Type;
                                Name   : in Chars_Ptr;
                                Value  : in Chars_Ptr)
     with Import => True, Convention => C, Link_Name => "g_hash_table_insert";

   --  ------------------------------
   --  Insert into the map the attribute with the given name and value.
   --  ------------------------------
   procedure Insert (Into  : in out Map;
                     Name  : in String;
                     Value : in String) is
   begin
      if Into.Opaque = System.Null_Address then
         Into.Opaque := Hash_Table_New_Full (Str_Hash'Access, Str_Compare'Access,
                                             Str_Free'Access, Str_Free'Access);
      end if;
      Hash_Table_Insert (Into.Opaque, New_String (Name), New_String (Value));
   end Insert;

   overriding
   procedure Adjust (Object : in out Map) is
   begin
      if Object.Opaque /= System.Null_Address then
         Object.Opaque := Hash_Table_Ref (Object.Opaque);
      end if;
   end Adjust;

   overriding
   procedure Finalize (Object : in out Map) is
   begin
      if Object.Opaque /= System.Null_Address then
         Hash_Table_Unref (Object.Opaque);
      end if;
   end Finalize;

end Secret.Attributes;
