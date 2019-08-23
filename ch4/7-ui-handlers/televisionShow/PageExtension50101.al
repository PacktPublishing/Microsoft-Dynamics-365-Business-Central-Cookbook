pageextension 50101 PageExtension50101 extends "Item Card"
{
  layout
  {
    moveafter(Description;"Item Category Code")
    modify(Type)
    {
    Visible = false;
    }
    addafter(Description)
    {
      field("Description 2";"Description 2")
      {
        ApplicationArea = All;
      }
    }
  }
}