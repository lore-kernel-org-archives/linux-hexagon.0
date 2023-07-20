From: Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH v2 1/9] vgacon: rework Kconfig dependencies
Date: Thu, 20 Jul 2023 12:48:47 -0600
Message-ID: <aea82980-358a-863f-d6a0-66f4ce3f87b7@gonehiking.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-2-arnd@kernel.org>
Reply-To: khalid@gonehiking.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NQwSB87aNJbALjnm9C/R6zCaK7ZpPsm12o+o9rxC7b4=; b=vWEgNj+wl2m36K
	iGt10MOX+WLVNacRi4wz5TShil0PEtLfmBcurR/9ZLOhAW82DC3qIbh4dN3htiZyKp1mRy0m3stBm
	NVvYCcloyTBSTDwU06hlhIh3cTrXJ7nyCkNp2/nH/qyeFDDJk9I6tSrAz3ZPDaKjju+areF5VCn5u
	OsM68TkTScJinT++0X972GGUkR8huxv0ov9XLm0BrzJ572MtSrqX4wZARBte3Ee7VniFACWwuLIqq
	B1UT1+IcZ0UFOnEVfi6r5A0Cxo6u7OXzcjtjLloaTcAHPyeVlTuPTat8YW5pDPoEk2HJeBuFHzTfj
	hvaFPYLMdC9bGbcyvCaA==;
Content-Language: en-US
In-Reply-To: <20230719123944.3438363-2-arnd@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guo Ren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Linus Walleij <linus.walleij@linaro.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael

On 7/19/23 6:39 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The list of dependencies here is phrased as an opt-out, but this is missing
> a lot of architectures that don't actually support VGA consoles, and some
> of the entries are stale:
> 
>   - powerpc used to support VGA consoles in the old arch/ppc codebase, but
>     the merged arch/powerpc never did
> 
>   - arm lists footbridge, integrator and netwinder, but netwinder is actually
>     part of footbridge, and integrator does not appear to have an actual
>     VGA hardware, or list it in its ATAG or DT.
> 
>   - mips has a few platforms (malta, sibyte, and sni) that initialize
>     screen_info, on everything else the console is selected but cannot
>     actually work.
> 
>   - csky, hexgagon, loongarch, nios2, riscv and xtensa are not listed
>     in the opt-out table and declare a screen_info to allow building
>     vga_con, but this cannot work because the console is never selected.
> 
> Replace this with an opt-in table that lists only the platforms that
> remain. This is effectively x86, plus a couple of historic workstation
> and server machines that reused parts of the x86 system architecture.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Khalid Aziz <khalid@gonehiking.org>


> ---
>   drivers/video/console/Kconfig | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 1b5a319971ed0..6af90db6d2da9 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -7,9 +7,9 @@ menu "Console display driver support"
>   
>   config VGA_CONSOLE
>   	bool "VGA text console" if EXPERT || !X86
> -	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
> -		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
> -		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390 && !UML
> +	depends on ALPHA || IA64 || X86 || \
> +		(ARM && ARCH_FOOTBRIDGE) || \
> +		(MIPS && (MIPS_MALTA || SIBYTE_BCM112X || SIBYTE_SB1250 || SIBYTE_BCM1x80 || SNI_RM))
>   	select APERTURE_HELPERS if (DRM || FB || VFIO_PCI_CORE)
>   	default y
>   	help
