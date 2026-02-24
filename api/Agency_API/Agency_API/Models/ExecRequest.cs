namespace Agency_API.Models
{
    public class ExecRequest
    {
        // שם הפרוצדורה שנרצה להריץ (למשל: GetAllApartments)
        public string ProcedureName { get; set; }

        // רשימת הפרמטרים (למשל: מחיר, עיר וכו')
        public Dictionary<string, object> Parameters { get; set; }
    }
}