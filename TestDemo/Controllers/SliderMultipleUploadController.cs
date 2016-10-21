using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TestDemo.Models.CustomModels;
using TestDemo.Models;
using TestDemo.Models.Repository;

namespace TestDemo.Controllers
{
    public class SliderMultipleUploadController : Controller
    {
        private TestDemoEntities db = new TestDemoEntities();

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        //
        // GET: /SliderMultipleUpload/
        public ActionResult SliderMultipleUpload()
        {
            using (var repo = new SliderRepository())
            {
                var model = repo.GetList();
                return this.View(model);
            }
        }

        public ActionResult Delete(long id = 0)
        {
            using (var repo = new SliderRepository())
            {
                var data = repo.DeleteRecord(id);
                if(!data)
                {
                    return HttpNotFound();
                }
                var model = repo.GetList();
                return this.PartialView("P_List", model);
            }
        }

        [HttpPost]
        public ActionResult SliderMultipleUpload(SliderModel slider)
        {
            using (var repo = new SliderRepository())
            {
                if (((System.Web.HttpPostedFileBase[])(slider.ImageS))[0] != null)
                {
                    List<tblSlider> fileDetails = new List<tblSlider>();
                    //for (int i = 0; i < slider.Image.Count; i++)
                    foreach (var file in slider.ImageS)
                    {
                        //var file = Request.Files[img];
                        tblSlider fileDetail = new tblSlider();
                        if (file != null && file.ContentLength > 0)
                        {
                            var fileName = Path.GetFileName(file.FileName);
                            var imageName = DateTime.Now.Ticks;
                            fileDetail = new tblSlider()
                            {
                                SImage = @"/Upload/Slider/" + imageName + Path.GetExtension(fileName),
                                IsActive = true,
                                IsDelete = false
                            };
                            fileDetails.Add(fileDetail);

                            var path = Path.Combine(Server.MapPath("~/Upload/Slider/"), imageName + Path.GetExtension(fileName));
                            file.SaveAs(path);
                        }
                        db.tblSliders.Add(fileDetail);
                        db.SaveChanges();
                    }
                }

                var model = repo.GetList();
                return this.PartialView("P_List", model);
            }
        }
    }
}