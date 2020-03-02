From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] mm/special: Create generic fallbacks for pte_special()
 and pte_mkspecial()
Date: Mon, 2 Mar 2020 18:16:35 +0900
Message-ID: <20200302091635.GK7926@lianli.shorne-pla.net>
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndch3h4URTloyii1gSOs74b+yGmOg265tPn81wcSc2E=;
        b=vL0VVsuaaoEsbUHMmRXA6lfSc7FopuGlr36i0AXnSjtq/HXbT/8a6v2h2NFzs7jmga
         DQNmZYmIN2qjCn4v4UprQ1hhz87Li5nLtHphVK3d096BA9X8u9jvsl+X1E12z9uDygY0
         tDZeDZt7dIcEa5iu/48Zcj9kqwt/Afy8lQ2vPLl7eyAB1mcmVl07n5BrFg1XH9SvUM4V
         cODnqdSWYkDAaS9/SYbnZvwG7/Jwq9o5rMX/rJPp73ybLwKm3V2HM/o4EREpet7DoAG4
         6ELWoIXedXfCwuV2u4nSq8sFAeFOZrb5Dfj1fao4CFdutyOVFG77o0e8I3Wc9gSbNNju
         9spQ==
Content-Disposition: inline
In-Reply-To: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Creasey <sammy@sammy.net>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, "James E.J. Bottomley" <James.Bottomley@han>

On Mon, Mar 02, 2020 at 07:26:30AM +0530, Anshuman Khandual wrote:

> diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
> index 248d22d8faa7..7f3fb9ceb083 100644
> --- a/arch/openrisc/include/asm/pgtable.h
> +++ b/arch/openrisc/include/asm/pgtable.h
> @@ -236,8 +236,6 @@ static inline int pte_write(pte_t pte) { return pte_val(pte) & _PAGE_WRITE; }
>  static inline int pte_exec(pte_t pte)  { return pte_val(pte) & _PAGE_EXEC; }
>  static inline int pte_dirty(pte_t pte) { return pte_val(pte) & _PAGE_DIRTY; }
>  static inline int pte_young(pte_t pte) { return pte_val(pte) & _PAGE_ACCESSED; }
> -static inline int pte_special(pte_t pte) { return 0; }
> -static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
>  
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {

For openrisc bits:

Acked-by: Stafford Horne <shorne@gmail.com>
 
