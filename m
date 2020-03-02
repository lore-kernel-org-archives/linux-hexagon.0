From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm/special: Create generic fallbacks for pte_special()
 and pte_mkspecial()
Date: Mon, 2 Mar 2020 16:07:27 +0530
Message-ID: <02997860-9374-28b9-8703-dc9b62b3f8ff@arm.com>
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
 <CAMuHMdXnUeYib2dMALyzrW8LKhTjsnGFsqALoTxVHzPGc+OUTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6hBkH3kHpOSd1Jq5xcMHbrEwViL7BTbr6FyB/Qf2Jgo=; b=OhBdrUoexYq1v0
	dhCXmM3dZmEbONmJ0ukVp5nyLEZ0n9gk84x1CO2X556oasRgt2mcVrPuCQZ+QMmDOYM53j2ZJff3u
	WKqbCB2FLs+g0Er6w4PDeV2B3tEzoadqPncyTQjfwt10A/ZdpsI96Y57UZRz+ABGuY/P/Jt9f73+J
	eKM2abS0zoGxvMGtPMBjIW3xACe+J7NCwAmWJawa1PXCysDVvZ4Stv+YwO8B4RWyTsFl2GkK23HTK
	tYSej1fGbEcB2ndNbsBy5/7kHf2sUIWFEDKbVlRd/7d28qPb0RDqSqfQULp8BRHNUwFn6it+NQOuS
	HB+EjyKVWnrwkQRo/0fw==;
In-Reply-To: <CAMuHMdXnUeYib2dMALyzrW8LKhTjsnGFsqALoTxVHzPGc+OUTg@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Linux MM <linux-mm@kvack.org>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, Paul Burton <paulburton@kernel.org>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Parisc List <linux-parisc@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Matt Turner <mattst88@gmail.com>, Sam


On 03/02/2020 01:49 PM, Geert Uytterhoeven wrote:
> Hi Anshuman,
> 
> Thanks for your patch!
> 
> On Mon, Mar 2, 2020 at 2:56 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> Currently there are many platforms that dont enable HAVE_ARCH_PTE_SPECIAL
> ARCH_HAS_PTE_SPECIAL
> 
>> but required to define quite similar fallback stubs for special page table
>> entry helpers such as pte_special() and pte_mkspecial(), as they get build
>> in generic MM without a config check. This creates two generic fallback
>> stub definitions for these helpers, eliminating much code duplication.
>>
>> mips platform has a special case where pte_special() and pte_mkspecial()
>> visibility is wider than what HAVE_ARCH_PTE_SPECIAL enablement requires.
> ARCH_HAS_PTE_SPECIAL
> 

Oops, will fix it. I have been juggling between too many HAVE_ARCH_* and
ARCH_HAS_* lately :)
