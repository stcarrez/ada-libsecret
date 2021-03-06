-----------------------------------------------------------------------
--  Secret -- Ada wrapper for Secret Service
--  Copyright (C) 2017, 2019 Stephane Carrez
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
with System;
with Ada.Finalization;
private with Interfaces.C.Strings;

--  == Secret Service API ==
--  The Secret Service API is a service developped for the Gnome keyring and the KDE KWallet.
--  It allows application to access and manage stored passwords and secrets in the two
--  desktop environments.  The libsecret is the C library that gives access to the secret
--  service.  The <tt>Secret</tt> package provides an Ada binding for this secret service API.
--
--  @include secret-values.ads
--  @include secret-attributes.ads
--  @include secret-services.ads
package Secret is

   type Object_Type is tagged private;

   --  Check if the value is empty.
   function Is_Null (Value : in Object_Type'Class) return Boolean;

private

   use type System.Address;

   subtype Opaque_Type is System.Address;

   type Object_Type is new Ada.Finalization.Controlled with record
      Opaque : Opaque_Type := System.Null_Address;
   end record;

   --  Internal operation to set the libsecret internal pointer.
   procedure Set_Opaque (Into : in out Object_Type'Class;
                         Data : in Opaque_Type);

   --  Internal operation to get the libsecret internal pointer.
   function Get_Opaque (From : in Object_Type'Class) return Opaque_Type;

   subtype Chars_Ptr is Interfaces.C.Strings.chars_ptr;

   procedure Free (P : in out Chars_Ptr)
      renames Interfaces.C.Strings.Free;

   function To_String (P : Chars_Ptr) return String
      renames Interfaces.C.Strings.Value;

   function New_String (V : in String) return Chars_Ptr
      renames Interfaces.C.Strings.New_String;

   type GError_Type is record
      Domain  : Interfaces.Unsigned_32 := 0;
      Code    : Interfaces.C.int := 0;
      Message : Chars_Ptr;
   end record with Convention => C;

   type GError is access all GError_Type with Convention => C;

   pragma Linker_Options ("-lsecret-1");
   pragma Linker_Options ("-lglib-2.0");
   pragma Linker_Options ("-lgio-2.0");
   --  pragma Linker_Options ("-liconv");
end Secret;
