using Core.DataAccess.EntityFramework;
using DataAccess.Abstracts;
using Entities.Concretes;
using Entities.Dtos;

namespace DataAccess.Concretes.EntityFramework
{
    public class EfFavoriteDal : EfEntityRepositoryBase<Favorite, BaseDbContext>, IFavoriteDal
    {
        public List<FavoriteDto> GetAllFavoriteProductByUserId(int userId)
        {
            using (BaseDbContext context = new BaseDbContext())
            {
                var result = from favorite in context.Favorites
                             join product in context.Products on favorite.ProductId equals product.Id
                             where favorite.UserId == userId
                             select new FavoriteDto
                             {
                                 Id = favorite.Id,
                                 ProductDescription = product.Description,
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
