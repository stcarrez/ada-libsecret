-----------------------------------------------------------------------
--  secret-tool -- Example of usage for the Secret service API
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
with Ada.Command_Line;
with Ada.Text_IO;
with Secret.Services;
with Secret.Attributes;
with Secret.Values;
procedure Secret.Tool is
   Count   : constant Natural := Ada.Command_Line.Argument_Count;
   Service : Secret.Services.Service_Type;
   List    : Secret.Attributes.Map;
   Value   : Secret.Values.Secret_Type;
begin
   Service.Initialize;
   List.Insert ("secret-tool", "key-password");
   List.Insert ("user", "joe");
   List.Insert ("email", "joe@gmail.com");
   if Count = 1 and then Ada.Command_Line.Argument (1) = "get" then
      Value := Service.Lookup (List);
      if Value.Is_Null then
         Ada.Text_IO.Put_Line ("The secret value is not found");
      else
         Ada.Text_IO.Put_Line ("Secret value is: " & Value.Get_Value);
      end if;
   elsif Count = 2 and then Ada.Command_Line.Argument (1) = "set" then
      Value := Secret.Values.Create (Ada.Command_Line.Argument (2));
      Service.Store (List, "Secret tool password", Value);

   elsif Count = 1 and then Ada.Command_Line.Argument (1) = "del" then
      Service.Remove (List);
   else
      Ada.Text_IO.Put_Line ("Usage: secret-tool [get|del]");
      Ada.Text_IO.Put_Line ("       secret-tool set value");
      Ada.Text_IO.Put_Line ("set  set the secret value");
      Ada.Text_IO.Put_Line ("get  get the secret value");
      Ada.Text_IO.Put_Line ("del  delete the secret value");
   end if;
end Secret.Tool;
