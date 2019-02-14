From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH 4/4] riscv: switch over to generic free_initmem()
Date: Thu, 14 Feb 2019 12:49:45 -0800 (PST)
Message-ID: <mhng-e6dedfc5-937e-42e5-90d6-4ce400cbc6fb@palmer-si-x1c4>
References: <1550159977-8949-5-git-send-email-rppt@linux.ibm.com>
Mime-Version: 1.0 (MHng)
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=65fCph2wVQLYLbAYl3Kh/IhOwVLd3uOG3Na/8tJTTl0=;
        b=lLQgQe9BdP6L/KKozxCy89gHttaXJ4MA/yuhOBLCl/O1eO8ekEikoBlRb07TggKmfT
         VEnZJpuB+R0alfezZ07DaC4KjxaWVhFw87+QptUw3Qfceuu+A4AqmvxsZpbt9TUicHg0
         pIp0nAUSBY9GINxAhjuu7lkJv4M3cJfYaDkCYM+E7KxXxeADn7bOhq3P6BdJtOi9Set7
         geGOodJQ42skGi7BhAPn2OSrGFUbhESwVHmVG7K3mUc/QqnryZ1A1g4gvHOsa+GHi8Wr
         7v0wAKu9AsvGvisJ9miN0oRC+7goN7MaAvA0WXXEqzHznU5rKaZN10qjHoUKTWZ9V4Qs
         vxxQ==
In-Reply-To: <1550159977-8949-5-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: akpm@linux-foundation.org, Christoph Hellwig <hch@lst.de>, rkuo@codeaurora.org, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, rppt@linux.ibm.com

On Thu, 14 Feb 2019 07:59:37 PST (-0800), rppt@linux.ibm.com wrote:
> The riscv version of free_initmem() differs from the generic one only in
> that it sets the freed memory to zero.
>
> Make ricsv use the generic version and poison the freed memory.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/riscv/mm/init.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 658ebf6..2af0010 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -60,11 +60,6 @@ void __init mem_init(void)
>  	mem_init_print_info(NULL);
>  }
>
> -void free_initmem(void)
> -{
> -	free_initmem_default(0);
> -}
> -
>  #ifdef CONFIG_BLK_DEV_INITRD
>  void free_initrd_mem(unsigned long start, unsigned long end)
>  {

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I'm going to assume this goes in with the rest of the patch set, thanks!
