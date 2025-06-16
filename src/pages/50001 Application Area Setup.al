page 50001 "Application Area Setup Base"
{
    ApplicationArea = All;
    Caption = 'Application Area Setup';
    PageType = List;
    SourceTable = "Application Area Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Profile ID"; Rec."Profile ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sales Tax"; Rec."Sales Tax")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
