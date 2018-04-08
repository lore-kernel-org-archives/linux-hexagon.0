From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 1/3] hexagon: fix ffz/fls/ffs return type
Date: Sat, 7 Apr 2018 20:35:25 -0500
Message-ID: <20180408013525.GE3036@codeaurora.org>
References: <20180406142832.2243021-1-arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523151328;
        bh=GEvtb404zT5+/Gp4ZLE0W8dHnOs3CO62LItd6Nb4ibA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKZyPNB9TaRQB3GQj81CDYAUvCPzU4WA6KTmCayNoEzM7NNyqVgZYaRCl1Kr+dmph
         T+HZ9gMTvtrzCALjGGPt2h0uNSbfCck8rLDCsOOxQ7GgZrmhKpI5/r+xsG7ooZWxeu
         HRjjzT/4SZTdoQ36TxntR71+bxg8F3gh1tu77PG4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523151327;
        bh=GEvtb404zT5+/Gp4ZLE0W8dHnOs3CO62LItd6Nb4ibA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFexcBCrXfZDVkEo5oUt76vgWFWfi6ZVgVB7CtyIwBm4BPfxO/AINTixCjK5D1MyS
         IYMzLZIJpmAoonuchEdK4W/4MQ7BRojDyOUZFM8tKzTIl9y3zl4k3bvS5qMZXeDu2X
         qb6lOvXq1XlZjPsXF3Y4DCDY+ruS3ZRnTLuvhsV0=
Content-Disposition: inline
In-Reply-To: <20180406142832.2243021-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:28:21PM +0200, Arnd Bergmann wrote:
> Let's use the same return type as the major architectures to
> avoid warnings like
> 
> drivers/ata/libahci_platform.c: In function 'ahci_platform_init_host':
> drivers/ata/libahci_platform.c:561:12: warning: comparison of distinct pointer types lacks a cast [enabled by default]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/hexagon/include/asm/bitops.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
> index 5e4a59b3ec1b..8790a50b1f5e 100644
> --- a/arch/hexagon/include/asm/bitops.h
> +++ b/arch/hexagon/include/asm/bitops.h
> @@ -194,7 +194,7 @@ static inline int __test_bit(int nr, const volatile unsigned long *addr)
>   *
>   * Undefined if no zero exists, so code should check against ~0UL first.
>   */
> -static inline long ffz(int x)
> +static inline int ffz(int x)
>  {
>  	int r;
>  
> @@ -211,7 +211,7 @@ static inline long ffz(int x)
>   * This is defined the same way as ffs.
>   * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
>   */
> -static inline long fls(int x)
> +static inline int fls(int x)
>  {
>  	int r;
>  
> @@ -232,7 +232,7 @@ static inline long fls(int x)
>   * the libc and compiler builtin ffs routines, therefore
>   * differs in spirit from the above ffz (man ffs).
>   */
> -static inline long ffs(int x)
> +static inline int ffs(int x)
>  {
>  	int r;
>  


Isn't ffz usually long/unsigned long on other architectures?





-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
