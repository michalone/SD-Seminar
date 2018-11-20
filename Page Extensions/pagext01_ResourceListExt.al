pageextension 50101 "CSD Resource List Ext" extends "Resource List"
{
    layout
    {
        addafter(Type)
        {
            field("CSD Resource Type"; "CSD Resource Type")
            {

            }
            field("CSD Maximum Participants"; "CSD Maximum Participants")
            {
                Visible = showRoom;
            }
        }
        modify(Type)
        {
            Visible = showType;
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        showType := (GetFilter(Type) = '');
        showRoom := (GetFilter(Type) = format(Type::Machine));       
    end;

    var
        [InDataSet]
        showRoom : Boolean;
        [InDataSet]
        showType : Boolean;
}