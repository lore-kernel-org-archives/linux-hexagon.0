From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Date: Wed, 5 Jan 2022 07:32:48 +0800
Message-ID: <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641339175;
        bh=86C2wftjndtAK2iWcv41C0xFmPUyW3b0hrtgz4GnTTg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JwVFYQFMRqPO1greU7wXOsdkZxbBXgeOffBsHfV7QiF/dzCXwg3e27fyAyiQNIzaY
         qttcIGNq9t1ZO7Od7FycmOhlRu1x+nvuF+AnuxO/OxN/nH77Iq0J0JiYFaQGa9X8K4
         RfH6mG26/af5uABh9PDs3IGpUHs176MGd/Vrp1e4=
Content-Language: en-US
In-Reply-To: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org, linux-hexagon@vger.kernel.org

Hi Christophe,

I'm recently enhancing the subpage support for btrfs, and my current
branch should solve the problem for btrfs to support larger page sizes.

But unfortunately my current test environment can only provide page size
with 64K or 4K, no 16K or 128K/256K support.

Mind to test my new branch on 128K page size systems?
(256K page size support is still lacking though, which will be addressed
in the future)

https://github.com/adam900710/linux/tree/metadata_subpage_switch

Thanks,
Qu

On 2021/6/10 13:23, Christophe Leroy wrote:
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
>
>   	help
>   	  Btrfs is a general purpose copy-on-write filesystem with extents,
