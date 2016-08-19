using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TestDemo.Startup))]
namespace TestDemo
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
