From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Date: Fri, 11 Jun 2021 21:47:39 +0800
Message-ID: <a2411cbb-d793-5e11-dd4f-cc25ca55ed91@gmx.com>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623419269;
        bh=DQZaNV/hwR/W07WPShIulNh1yaAYynzVvSqkCu5eIgw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gv0lZuxvaCRSdJw9ALtXnvPNz0RpqA3o41KJkHnFS3JAjFQN0NXaOJPZaJGXTvfRW
         cRfk/2pcZiRH3pYPujayL27QT3O3kXFTqWzKe5XgNOYazGOEsu4txjz+xPemm2fyAr
         YAjNey8WEfRl/vTGUIWJQwCexlRqJdpxyNvj5fgc=
In-Reply-To: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org, linux-hexagon@vger.kernel.org



On 2021/6/10 =E4=B8=8B=E5=8D=881:23, Christophe Leroy wrote:
> With a config having PAGE_SIZE set to 256K, BTRFS build fails
> with the following message
>
>   include/linux/compiler_types.h:326:38: error: call to '__compiletime_a=
ssert_791' declared with attribute error: BUILD_BUG_ON failed: (BTRFS_MAX_=
COMPRESSED % PAGE_SIZE) !=3D 0
>
> BTRFS_MAX_COMPRESSED being 128K, BTRFS cannot support platforms with
> 256K pages at the time being.
>
> There are two platforms that can select 256K pages:
>   - hexagon
>   - powerpc
>
> Disable BTRFS when 256K page size is selected.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   fs/btrfs/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 68b95ad82126..520a0f6a7d9e 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -18,6 +18,8 @@ config BTRFS_FS
>   	select RAID6_PQ
>   	select XOR_BLOCKS
>   	select SRCU
> +	depends on !PPC_256K_PAGES	# powerpc
> +	depends on !PAGE_SIZE_256KB	# hexagon

I'm OK to disable page size other than 4K, 16K, 32K, 64K for now.

Although for other reasons.

Not only for the BUILD_BUG_ON(), but for the fact that btrfs only
support 4K, 16K, 32K, 64K sectorsize, and requires PAGE_SIZE =3D=3D sector=
size.

Although we're adding subpage support, the subpage support only comes
with 4K sectorsize on 64K page size.

Until variable length version is introduced, 256K/128K page size won't
be support.

Thus I'm fine to disable BTRFS for any arch outside of the supported
page sizes for now.

Thanks,
Qu
>
>   	help
>   	  Btrfs is a general purpose copy-on-write filesystem with extents,
>
