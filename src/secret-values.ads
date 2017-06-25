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

--  === Secret Values ===
--  A secret value is represented by the <tt>Secret_Type</tt> type.  The value is internally
--  held and managed by the libsecret in some secure memory region.   The secret value is
--  associated with a content type that can be retrieved as well.  The Ada library only creates
--  secret values with the "text/plain" content type.
--
--  A secret value is only copied by reference that is the secret value stored in the secure
--  memory region is shared among different <tt>Secret_Type</tt> instances.  A secret value
--  cannot be modified once it is created.
--
--  To create a secret value, you can use the <tt>Create</tt> function as follows:
--
--    Value : Secret.Values.Secret_Type := Secret.Values.Create ("my-secret-password");
--
package Secret.Values is

   --  Represents a value returned by the secret server.
   type Secret_Type is new Object_Type with null record;

   --  Create a value with the default content type text/plain.
   function Create (Value : in String) return Secret_Type
     with Post => not Create'Result.Is_Null;

   --  Get the value content type.
   function Get_Content_Type (Value : in Secret_Type) return String
     with Pre => not Value.Is_Null;

   --  Get the value as a string.
   function Get_Value (Value : in Secret_Type) return String
     with Pre => not Value.Is_Null;

private

   overriding
   procedure Adjust (Object : in out Secret_Type);

   overriding
   procedure Finalize (Object : in out Secret_Type);

end Secret.Values;
