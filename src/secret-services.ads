-----------------------------------------------------------------------
--  secret-services -- Ada wrapper for Secret Service
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
with Secret.Attributes;
with Secret.Values;

--  === Secret Service ===
--  The <tt>Secret.Services</tt> package defines the <tt>Service_Type</tt> that gives
--  access to the secret service provided by the desktop keyring manager.  The service
--  instance is declared as follows:
--
--    Service : Secret.Services.Service_Type;
--
--  The initialization is optional since the libsecret API will do the initialization itself
--  if necessary.  However, the initialization could be useful to indicate to open a session
--  and/or to load the collections.  In that case, the <tt>Initialize</tt> procedure is called:
--
--    Service.Initialize (Open_Session => True);
--
--  The list of attributes that allows to retrieve the secret value must be declared and
--  initialized with the key/value pairs:
--
--    Attr : Secret.Attributes.Map;
--
--  and the key/value pairs are inserted as follows:
--
--    Attr.Insert ("my-key", "my-value");
--
--  The secret value is represented by the <tt>Secret_Type</tt> and it is initialized as
--  follows:
--
--    Value : Secret.Values.Secret_Type := Secret.Values.Create ("my-password-to-protect");
--
--  Then, storing the secret value is done by the <tt>Store</tt> procedure and the label
--  is given to help identifying the value from the keyring manager:
--
--    Service.Store (Attr, "Application password", Value);
--
package Secret.Services is

   Service_Error : exception;

   type Service_Type is new Object_Type with null record;

   --  Initialize the secret service instance by getting a secret service proxy and
   --  making sure the service has the service flags initialized.
   procedure Initialize (Service          : out Service_Type;
                         Open_Session     : in Boolean := False;
                         Load_Collections : in Boolean := False);

   --  Store the value in the secret service identified by the attributes and associate
   --  the value with the given label.
   procedure Store (Service : in Service_Type;
                    Attr    : in Secret.Attributes.Map;
                    Label   : in String;
                    Value   : in Secret.Values.Secret_Type)
     with Pre => not Attr.Is_Null and then not Value.Is_Null;

   --  Lookup in the secret service the value identified by the attributes.
   function Lookup (Service : in Service_Type;
                    Attr    : in Secret.Attributes.Map) return Secret.Values.Secret_Type
     with Pre => not Attr.Is_Null;

   --  Remove from the secret service the value associated with the given attributes.
   procedure Remove (Service : in Service_Type;
                     Attr    : in Secret.Attributes.Map)
     with Pre => not Attr.Is_Null;

end Secret.Services;
