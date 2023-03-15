@echo off 
set obj[0].Name=Joe 
set obj[0].ID=1 
set obj[1].Name=Mark 
set obj[1].ID=2 
set obj[2].Name=Mohan 
set obj[2].ID=3 
for /L %%i in (0 1 2) do (
   call echo Name = %%obj[%%i].Name%%
   call echo Value = %%obj[%%i].ID%%
)