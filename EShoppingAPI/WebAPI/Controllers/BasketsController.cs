using Business.Abstracts;
using Entities.Concretes;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BasketsController : ControllerBase
    {
        IBasketService _basketService;

        public BasketsController(IBasketService basketService)
        {
            _basketService = basketService;
        }
        [HttpPost("DeleteAllByUserId")]
        public IActionResult DeleteAllByUserId(int userId)
        {
            var result = _basketService.DeleteAllByUserId(userId);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest();
        }

        [HttpPost("Add")]
        public IActionResult Add(Basket basket)
        {
            var result = _basketService.Add(basket);
            if (result.Success) {
                return Ok(result);
            }
            return BadRequest(result);
        }
        [HttpPost("Delete")]
        public IActionResult Delete(Basket basket)
        {
            var result = _basketService.Delete(basket);
            if (result.Success)
            {
                return Ok(result);
            }
            return BadRequest(result);
        }
        [HttpGet("GetAllBasketProductByUserId")]
        public IActionResult GetAllBasketProductByUserId(int userId)
        {
            var result = _basketService.GetAllBasketProductByUserId(userId);
            if (result.Success) { 
                return Ok(result);  
            }
            return BadRequest(result);
        }
    }
}
