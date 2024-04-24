using Core.DataAccess.EntityFramework;
using DataAccess.Abstracts;
using Entities.Concretes;

namespace DataAccess.Concretes.EntityFramework
{
    public class EfProductDal : EfEntityRepositoryBase<Product, BaseDbContext>, IProductDal
    {
    }
   
}
