-----------------------------------------------------------------------
--  Secret -- Ada wrapper for Secret Service
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

package body Secret is

   --  ------------------------------
   --  Check if the value is empty.
   --  ------------------------------
   function Is_Null (Value : in Object_Type'Class) return Boolean is
   begin
      return Value.Opaque = System.Null_Address;
   end Is_Null;

   --  ------------------------------
   --  Internal operation to set the libsecret internal pointer.
   --  ------------------------------
   procedure Set_Opaque (Into : in out Object_Type'Class;
                         Data : in Opaque_Type) is
   begin
      Into.Opaque := Data;
   end Set_Opaque;

   --  ------------------------------
   --  Internal operation to get the libsecret internal pointer.
   --  ------------------------------
   function Get_Opaque (From : in Object_Type'Class) return Opaque_Type is
   begin
      return From.Opaque;
   end Get_Opaque;

end Secret;
