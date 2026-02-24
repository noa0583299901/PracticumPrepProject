using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Dapper;
using System.Data;
using Agency_API.Models; // ודאי שזה שם ה-Namespace של הפרויקט שלך

[Route("api/[controller]")]
[ApiController]
public class ExecController : ControllerBase
{
    private readonly string _connectionString;

    // הקונסטרקטור קורא את מחרוזת החיבור מ-appsettings.json
    public ExecController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    [HttpPost("exec")]
    public async Task<IActionResult> ExecuteProcedure([FromBody] ExecRequest request)
    {
        try
        {
            using (IDbConnection db = new SqlConnection(_connectionString))
            {
                // המרת הפרמטרים למבנה ש-Dapper מבין כדי למנוע שגיאת JsonElement
                var dynamicParameters = new DynamicParameters();
                if (request.Parameters != null)
                {
                    foreach (var param in request.Parameters)
                    {
                        // חילוץ הערך האמיתי מתוך ה-JSON
                        var value = param.Value is System.Text.Json.JsonElement element
                                    ? element.GetRawText().Trim('"')
                                    : param.Value;

                        dynamicParameters.Add(param.Key, value);
                    }
                }

                // הרצת הפרוצדורה וקבלת התוצאות
                var result = await db.QueryAsync(
                    request.ProcedureName,
                    dynamicParameters,
                    commandType: CommandType.StoredProcedure
                );

                return Ok(result);
            }
        }
        catch (Exception ex)
        {
            // החזרת הודעת שגיאה מפורטת במקרה של תקלה
            return StatusCode(500, ex.Message);
        }
    }
}
