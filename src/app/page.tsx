import { fetchData } from "@/lib/fetchFunction";
import { BannerType, Product, ServiceType } from "@/Types/Types";


export const dynamic = 'force-dynamic';

export default async function Home() {

  const data = await fetchData("/home");

  const { banners, latestProducts, featuredProducts,featuredServices }: { banners: BannerType[], latestProducts: Product[], featuredProducts: Product[], featuredServices: ServiceType[] } = data.data;

  return (
    <div className="container mx-auto mt-4">
      Welcome

    </div>
  );
}
