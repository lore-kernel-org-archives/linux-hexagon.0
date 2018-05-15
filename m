From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] hexagon: fix printk format warning in setup.c
Date: Tue, 15 May 2018 14:03:26 -0500
Message-ID: <20180515190326.GC22553@codeaurora.org>
References: <adce8db5-4b01-dc10-7fbb-6a64e0787eb5@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526411009;
        bh=rrrhZD/aa3FuWbf7WCQK8bETXdWKvaxRj4XY1pYCSYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3WCJhjN/qvI3veV8Z378VLBORZxCuvrBjCgniCEXyzoPol5LOgtMqWWCVnaLxQyX
         gvL3f6wLwW49HPpkc71pGeWgaz/1I9PyW1n8BsdRYSsK25fxnbD5VNJ56Q1O/dMh+v
         4hqf2Hkl7ZD+UL0dWTYH3+nFy2KUq/HDqfVurWmU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1526411008;
        bh=rrrhZD/aa3FuWbf7WCQK8bETXdWKvaxRj4XY1pYCSYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUlTFNS/m6jbSu43FsLkvgoZWJaL5vIlRBiV+uwMWxdjRwkIQKkYywD6BMxjDH3L0
         0XdA2ZTQq5/7WhJlZWeYxTp7CaWRD9uSn1onKS8TTDY6aUyKQ04wzvC/s5oeiDaz9B
         SXOwp8YrYahYPu+9iqppNeT++c9EcTZNPJjVrs58=
Content-Disposition: inline
In-Reply-To: <adce8db5-4b01-dc10-7fbb-6a64e0787eb5@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sat, May 12, 2018 at 06:48:49PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix printk format warning in hexagon/kernel/setup.c:
> 
> ../arch/hexagon/kernel/setup.c: In function 'setup_arch':
> ../arch/hexagon/kernel/setup.c:69:2: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Wformat]
> 
> where:
> extern unsigned long	__phys_offset;
> #define PHYS_OFFSET	__phys_offset
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> ---
>  arch/hexagon/kernel/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20180510.orig/arch/hexagon/kernel/setup.c
> +++ linux-next-20180510/arch/hexagon/kernel/setup.c
> @@ -66,7 +66,7 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	__vmsetvec(_K_VM_event_vector);
>  
> -	printk(KERN_INFO "PHYS_OFFSET=0x%08x\n", PHYS_OFFSET);
> +	printk(KERN_INFO "PHYS_OFFSET=0x%08lx\n", PHYS_OFFSET);
>  
>  	/*
>  	 * Simulator has a few differences from the hardware.
> 
> 


Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
