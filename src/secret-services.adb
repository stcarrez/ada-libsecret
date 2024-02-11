-----------------------------------------------------------------------
--  secret-services -- Ada wrapper for Secret Service
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

package body Secret.Services is

   use type Interfaces.C.int;

   procedure Secret_Service_Store_Sync (Serv   : in System.Address;
                                        Schema : in System.Address;
                                        Attr   : in System.Address;
                                        Coll   : in System.Address;
                                        Label  : in Chars_Ptr;
                                        Value  : in System.Address;
                                        Cancel : in System.Address;
                                        Err    : in System.Address)
     with Import => True, Convention => C, Link_Name => "secret_service_store_sync";

   function Secret_Service_Lookup_Sync (Serv    : in System.Address;
                                        Schema  : in System.Address;
                                        Attr    : in System.Address;
                                        N       : in System.Address;
                                        Err     : in System.Address) return System.Address
     with Import => True, Convention => C, Link_Name => "secret_service_lookup_sync";

   function Secret_Service_Get_Sync (Flags : in Interfaces.C.int;
                                     Cancel : in System.Address;
                                     Err    : in System.Address) return System.Address
     with Import => True, Convention => C, Link_Name => "secret_service_get_sync";

   procedure Secret_Service_Clear_Sync (Serv   : in System.Address;
                                        Schema : in System.Address;
                                        Attr   : in System.Address;
                                        Cancel : in System.Address;
                                        Err    : in System.Address)
     with Import => True, Convention => C, Link_Name => "secret_service_clear_sync";

   --  ------------------------------
   --  Initialize the secret service instance by getting a secret service proxy and
   --  making sure the service has the service flags initialized.
   --  ------------------------------
   procedure Initialize (Service          : out Service_Type;
                         Open_Session     : in Boolean := False;
                         Load_Collections : in Boolean := False) is
      Error     : GError;
      Flags     : Interfaces.C.int;
   begin
      Flags := (if Open_Session then 1 else 0);
      Flags := Flags + (if Load_Collections then 4 else 0);
      Service.Opaque := Secret_Service_Get_Sync (Flags, System.Null_Address, Error'Address);
      if Error /= null then
         raise Service_Error with To_String (Error.Message);
      end if;
   end Initialize;

   --  ------------------------------
   --  Store the value in the secret service identified by the attributes and associate
   --  the value with the given label.
   --  ------------------------------
   procedure Store (Service : in Service_Type;
                    Attr    : in Secret.Attributes.Map;
                    Label   : in String;
                    Value   : in Secret.Values.Secret_Type) is
      Label_Str : Chars_Ptr := New_String (Label);
      Error     : GError;
   begin
      Secret_Service_Store_Sync (Get_Opaque (Service), System.Null_Address,
                                 Get_Opaque (Attr), System.Null_Address,
                                 Label_Str, Get_Opaque (Value),
                                 System.Null_Address, Error'Address);
      Free (Label_Str);
      if Error /= null then
         raise Service_Error with To_String (Error.Message);
      end if;
   end Store;

   --  ------------------------------
   --  Lookup in the secret service the value identified by the attributes.
   --  ------------------------------
   function Lookup (Service : in Service_Type;
                    Attr    : in Secret.Attributes.Map) return Secret.Values.Secret_Type is
      Error  : GError;
      Result : Secret.Values.Secret_Type;
   begin
      Set_Opaque (Result,
                  Secret_Service_Lookup_Sync (Get_Opaque (Service), System.Null_Address,
                    Get_Opaque (Attr), System.Null_Address,
                    Error'Address));
      if Error /= null then
         raise Service_Error with To_String (Error.Message);
      end if;
      return Result;
   end Lookup;

   --  Remove from the secret service the value associated with the given attributes.
   procedure Remove (Service : in Service_Type;
                     Attr    : in Secret.Attributes.Map) is
      Error : GError;
   begin
      Secret_Service_Clear_Sync (Get_Opaque (Service), System.Null_Address,
                                 Get_Opaque (Attr), System.Null_Address, Error'Address);
      if Error /= null then
         raise Service_Error with To_String (Error.Message);
      end if;
   end Remove;

end Secret.Services;
