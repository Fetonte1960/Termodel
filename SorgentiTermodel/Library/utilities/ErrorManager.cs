using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace Termodel.utilities
{
    public class ErrorManager
    {
        private static string errorMessage = "";

        public static string ErrorMessage
        {
            get { return errorMessage; }
            set { errorMessage = value; }
        }
        public static bool EsisteErrore()
        {
            if (!string.IsNullOrEmpty(errorMessage))
            {
                MessageBox.Show(errorMessage, "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
                errorMessage = ""; // Resetta il messaggio di errore dopo averlo mostrato
                return true;
            }
            return false;
        }
        public static void DisplayError()
        {
            if (!string.IsNullOrEmpty(errorMessage))
            {
                MessageBox.Show(errorMessage, "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
                errorMessage = ""; // Azzera il messaggio di errore dopo averlo mostrato
            }
        }
    }
}
