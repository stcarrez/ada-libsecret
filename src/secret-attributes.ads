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

--  === Secret Attributes ===
--  The secret attributes describes the key/value pairs that allows the secret service to
--  identify and retrieve a given secret value.  The secret attributes are displayed by the
--  keyring manager to the user in the "technical details" section.
--
--  The <tt>Secret.Attributes</tt> package defines the <tt>Map</tt> type for the representation
--  of attributes and it provides operations to populate the attributes.
--
--  The <tt>Map</tt> instances use reference counting and they can be shared.
package Secret.Attributes is

   --  Represents a hashmap to store attributes.
   type Map is new Secret.Object_Type with null record;

   --  Insert into the map the attribute with the given name and value.
   procedure Insert (Into  : in out Map;
                     Name  : in String;
                     Value : in String);

private

   overriding
   procedure Adjust (Object : in out Map);

   overriding
   procedure Finalize (Object : in out Map);

end Secret.Attributes;
