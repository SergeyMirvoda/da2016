using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Win32;
using RDotNet;

namespace RDotNetSample
{
    class Program
    {
        static void Main(string[] args)
        {
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-US");
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            //R Должен быть добавлен в переменную окружения PATH
            InitializeR();
            var engine = REngine.CreateInstance("RDotNet");
            engine.Initialize();
            engine.Evaluate("source('../../../createForecastFunctionSample.R')");
            var x = engine.CreateNumericVector(new[] { 2.0 });
            var y = engine.CreateNumericVector(new[] { 3.0 });
            engine.SetSymbol("x", x);
            engine.SetSymbol("y", y);
            var s = engine.Evaluate("forecast(x, y)").AsNumeric()[0];
            Console.WriteLine($"Получен результат: {s}. Нажмите любую кнопку для продолжения.");
            Console.ReadKey();
        }

        private static void InitializeR()
        {
            string path;
            using (var registryKey = Registry.LocalMachine.OpenSubKey(@"SOFTWARE\R-core\R"))
            {
                var version = registryKey.GetSubKeyNames()[0];
                path = (string) registryKey.OpenSubKey(version).GetValue("InstallPath");
            }

            var folderName = Environment.Is64BitProcess ? "x64" : "i386";
            var rBinPath = $"{path}{Path.DirectorySeparatorChar}bin{Path.DirectorySeparatorChar}{folderName}";

            var envPath = Environment.GetEnvironmentVariable("PATH");
            var rHome = Environment.GetEnvironmentVariable("R_HOME");
            if (string.IsNullOrEmpty(rHome) || new DirectoryInfo(rHome).Exists == false)
                throw new ApplicationException("Установите переменную окружения R_HOME.");
            Environment.SetEnvironmentVariable("PATH", envPath + Path.PathSeparator + rBinPath);
        }
    }
}
