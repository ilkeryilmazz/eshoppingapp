using Core.DataAccess.EntityFramework;
using Core.Utilities.Results;
using DataAccess.Abstracts;
using Entities.Concretes;
using Entities.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Concretes.EntityFramework
{
    public class EfBasketDal : EfEntityRepositoryBase<Basket, BaseDbContext>, IBasketDal
    {
        public List<BasketDto> GetAllBasketProductByUserId(int userId)
        {
            using (BaseDbContext context = new BaseDbContext())
            {
                var result = from basket in context.Baskets 
                             join product in context.Products on basket.ProductId equals product.Id
                             where basket.UserId == userId
                             select new BasketDto
                             {
                                 Id = basket.Id,
                                 ProductId=product.Id,
                                 ProductPrice = product.Price,
                                 ProductName = product.Name,
                                 ProductImage = product.ImageUrl
                             };
                return result.ToList();
            }
        }
    }
}
