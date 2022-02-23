From: Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH v2 07/18] nios2: drop access_ok() check from __put_user()
Date: Wed, 23 Feb 2022 17:30:53 -0600
Message-ID: <c6f461f1-1dd9-aec1-2c85-a3eda478a1be@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-8-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645659061;
        bh=lqCEQ++vi7cgL8SGDqvu6VRtg8aruPJlQBSjPBXBFVM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sbRe9FkUPCxCGG5QhSpQFHALisL4a0h67bCxhSLbAt1nLiwP1yIOk1Uj7FSa6KCb5
         weBLktMX2iJ1azUVoI5qzyIPsB248hdzJqK4FY8iQs4ijX9ClxGFEG4dPQ2t94Tu+v
         xnm83JKO7FsjVlGtupBZVZ1sGqkMArGtNnLjnEwqgMRRugYsRTn+yfOLhixpTMveFC
         hFyJk7dTbBRw3IsZy86rcTOonVkHxoMQs0BGW96T4vsXyVidvkbPH0uwFh8RFITz5K
         oD3k8dsNBCQPOLOspB8IOHbjF16KCCmPClOP9aOj20bxN2gTg9NdvWcdAxevymW0xQ
         hD4A1zZdc89kw==
Content-Language: en-US
In-Reply-To: <20220216131332.1489939-8-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Arnd Bergmann <arnd@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc: linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org, bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, nickhu@andestech.com, green.hu@gmail.com, shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org, davem@davemloft.net, richard@nod.at, x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com, akpm@linux-foundation.org, ardb@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org



On 2/16/22 07:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Unlike other architectures, the nios2 version of __put_user() has an
> extra check for access_ok(), preventing it from being used to implement
> __put_kernel_nofault().
> 
> Split up put_user() along the same lines as __get_user()/get_user()
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/nios2/include/asm/uaccess.h | 56 +++++++++++++++++++-------------
>   1 file changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
> index ca9285a915ef..a5cbe07cf0da 100644
> --- a/arch/nios2/include/asm/uaccess.h
> +++ b/arch/nios2/include/asm/uaccess.h
> @@ -167,34 +167,44 @@ do {									\
>   	: "r" (val), "r" (ptr), "i" (-EFAULT));				\
>   }
>   
> -#define put_user(x, ptr)						\
> +#define __put_user_common(__pu_val, __pu_ptr)				\
>   ({									\
>   	long __pu_err = -EFAULT;					\
> -	__typeof__(*(ptr)) __user *__pu_ptr = (ptr);			\
> -	__typeof__(*(ptr)) __pu_val = (__typeof(*ptr))(x);		\
> -	if (access_ok(__pu_ptr, sizeof(*__pu_ptr))) {	\
> -		switch (sizeof(*__pu_ptr)) {				\
> -		case 1:							\
> -			__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err); \
> -			break;						\
> -		case 2:							\
> -			__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err); \
> -			break;						\
> -		case 4:							\
> -			__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err); \
> -			break;						\
> -		default:						\
> -			/* XXX: This looks wrong... */			\
> -			__pu_err = 0;					\
> -			if (copy_to_user(__pu_ptr, &(__pu_val),		\
> -				sizeof(*__pu_ptr)))			\
> -				__pu_err = -EFAULT;			\
> -			break;						\
> -		}							\
> +	switch (sizeof(*__pu_ptr)) {					\
> +	case 1:								\
> +		__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err);	\
> +		break;							\
> +	case 2:								\
> +		__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err);	\
> +		break;							\
> +	case 4:								\
> +		__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err);	\
> +		break;							\
> +	default:							\
> +		/* XXX: This looks wrong... */				\
> +		__pu_err = 0;						\
> +		if (__copy_to_user(__pu_ptr, &(__pu_val),		\
> +			sizeof(*__pu_ptr)))				\
> +			__pu_err = -EFAULT;				\
> +		break;							\
>   	}								\
>   	__pu_err;							\
>   })
>   
> -#define __put_user(x, ptr) put_user(x, ptr)
> +#define __put_user(x, ptr)						\
> +({									\
> +	__auto_type __pu_ptr = (ptr);					\
> +	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
> +	__put_user_common(__pu_val, __pu_ptr);				\
> +})
> +
> +#define put_user(x, ptr)						\
> +({									\
> +	__auto_type __pu_ptr = (ptr);					\
> +	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
> +	access_ok(__pu_ptr, sizeof(*__pu_ptr)) ?			\
> +		__put_user_common(__pu_val, __pu_ptr) :			\
> +		-EFAULT;						\
> +})
>   
>   #endif /* _ASM_NIOS2_UACCESS_H */

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
