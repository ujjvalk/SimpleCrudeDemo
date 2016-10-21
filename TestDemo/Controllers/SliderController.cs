using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TestDemo.Models.Repository;
using TestDemo.Models.CustomModels;
using System.IO;

namespace TestDemo.Controllers
{
    public class SliderController : Controller
    {
        // GET: /Slider/
        public ActionResult Slider()
        {
            using (var repo = new SliderRepository())
            {
                var model = repo.GetList();
                return this.View(model);
            }
        }

        [HttpPost]
        public ActionResult Slider(SliderModel model)//,IEnumerable<HttpPostedFileBase> files)
        {
            using (var repo = new SliderRepository())
            {
                bool result = false;
                
                //foreach (var file in files)
                //{
                //    file.SaveAs(Server.MapPath("~/Upload/Slider/" + file.FileName));
                //}
                model.SImage = TempData["SImage"].ToString();
                if(model.SliderId > 0)
                {
                    result = repo.EditData(model);
                }
                else
                {
                    result = repo.AddData(model);
                }
                var data = repo.GetList();
                return this.PartialView("P_List", data);
            }
        }

        public ActionResult Edit(long id = 0)
        {
            using (var repo = new SliderRepository())
            {
                if (id > 0)
                {
                    var data = repo.GetById(id);
                    this.TempData["SImage"] = data.SImage;
                    return this.PartialView("P_Form", data);
                }
                return this.PartialView("P_Form");
            }
        }

        public ActionResult Delete(long id = 0)
        {
            using (var repo = new SliderRepository())
            {
                var data = repo.DeleteRecord(id);
                if (!data)
                {
                    return HttpNotFound();
                }
                var model = repo.GetList();
                return this.PartialView("P_List", model);
            }
        }

        #region Upload File
        [HttpPost]
        public void UploadFile()
        {
            for (var i = 0; i < Request.Files.Count; i++)
            {
                var file = Request.Files[i];
                if (file != null)
                {
                    var txt = DateTime.Now.Ticks;
                    string filePath = @"/Upload/Slider/";
                    if (!Directory.Exists(Server.MapPath(filePath)))
                    {
                        Directory.CreateDirectory(Server.MapPath(filePath));
                    }
                    var path = Server.MapPath(filePath) + txt + Path.GetExtension(file.FileName);
                    file.SaveAs(path);
                    this.TempData["SImage"] = filePath + txt + Path.GetExtension(file.FileName);
                }
            }
        }
        #endregion
    }
}