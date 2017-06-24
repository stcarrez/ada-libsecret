-----------------------------------------------------------------------
--  secret-tests - Unit tests for secret service library
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
with Util.Test_Caller;
with Ada.Text_IO;
with Secret.Values;
with Secret.Attributes;
with Secret.Services;
package body Secret.Tests is

   package Caller is new Util.Test_Caller (Test, "Secret.Service");

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite) is
   begin
      Caller.Add_Test (Suite, "Test Secret.Values",
                       Test_Value'Access);
      Caller.Add_Test (Suite, "Test Secret.Attributes",
                       Test_Attributes'Access);
      Caller.Add_Test (Suite, "Test Secret.Service.Store",
                       Test_Store'Access);
   end Add_Tests;

   --  ------------------------------
   --  Test operations on the Secret_Type value.
   --  ------------------------------
   procedure Test_Value (T : in out Test) is
      V : Values.Secret_Type;
   begin
      T.Assert (V.Is_Null, "Secret_Type must be null");

      V := Values.Create ("test-secret");
      T.Assert (not V.Is_Null, "Secret_Type must not be null");
      Util.Tests.Assert_Equals (T, "test-secret", V.Get_Value,
                                "Invalid Get_Value");
      Util.Tests.Assert_Equals (T, "text/plain", V.Get_Content_Type,
                                "Invalid Get_Content_Type");

      V := Values.Create ("test-secret-2");
      Util.Tests.Assert_Equals (T, "test-secret-2", V.Get_Value,
                                "Invalid Get_Value");
      Util.Tests.Assert_Equals (T, "text/plain", V.Get_Content_Type,
                                "Invalid Get_Content_Type");
   end Test_Value;

   --  ------------------------------
   --  Test attributes operations.
   --  ------------------------------
   procedure Test_Attributes (T : in out Test) is
      List : Secret.Attributes.Map;
   begin
      T.Assert (List.Is_Null, "Attributes map must be null");
      Secret.Attributes.Insert (List, "my-name", "my-value");
      T.Assert (not List.Is_Null, "Attributes map must not be null");
   end Test_Attributes;

   procedure Test_Store (T : in out Test) is
      List : Secret.Attributes.Map;
      S    : Secret.Services.Service_Type;
      V    : Values.Secret_Type;
   begin
      S.Initialize;
      Secret.Attributes.Insert (List, "test-my-name", "my-value");
      V := Values.Create ("my-secret-value");
      S.Store (List, "my-test-password", V);
      Secret.Attributes.Insert (List, "secret-password-password", "admin");
      V := S.Lookup (List);
      if not V.Is_Null then
         Ada.Text_IO.Put_Line ("Value=" & V.Get_Value);
      end if;
   end Test_Store;

end Secret.Tests;
