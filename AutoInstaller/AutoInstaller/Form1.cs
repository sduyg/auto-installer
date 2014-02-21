using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace AutoInstaller
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //klasördeki dosyaları al

            var directory = new DirectoryInfo(@"C:\work\auto-installer\AutoInstaller\AutoInstaller\installers");
            var files = directory.GetFiles("*.ps1");

            //her dosya için bir textbox ekle


            for (int i = 0; i < files.Length; i++)
            {

                var checkboxName = files[i].Name.Replace(".ps1", "");

                CheckBox chk = new CheckBox();
                chk.Location = new Point(10, (20 * i) + 40);
                chk.Name = checkboxName;
                chk.Text = checkboxName;

                this.Controls.Add(chk);

            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //seçili checkboxları getir

            foreach (Control item in this.Controls)
            {
                CheckBox chk = item as CheckBox;
                if (chk != null)
                {
                    if (chk.Checked)
                    {
                        ProcessStartInfo startInfo = new ProcessStartInfo();
                        startInfo.FileName = @"powershell.exe";
                        startInfo.Arguments = @"& 'C:\work\auto-installer\AutoInstaller\AutoInstaller\installers\"+ chk.Name +".ps1'";

                        Process process = new Process();
                        process.StartInfo = startInfo;
                        process.Start();
                    }
                    
                }
            }
                       
            

        }


        public int max { get; set; }
    }

}

