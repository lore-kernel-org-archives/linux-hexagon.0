From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH V3 09/30] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date: Wed, 2 Mar 2022 11:19:22 +0000
Message-ID: <Yh9SuiayqcDdIB3B@shell.armlinux.org.uk>
References: <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
 <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
 <542fa048-131e-240b-cc3a-fd4fff7ce4ba@arm.com>
 <Yh1pYAOiskEQes3p@shell.armlinux.org.uk>
 <dc3c95a4-de06-9889-ce1e-f660fc9fbb95@csgroup.eu>
 <c3b60de0-38cd-160a-aa15-831349e07e23@arm.com>
 <52866c88-59f9-2d1c-6f5a-5afcaf23f2bb@csgroup.eu>
 <9caa90f5-c10d-75dd-b403-1388b7a3d296@arm.com>
 <CAMuHMdU11kaOzanhHZRH+mLTJzaz-i=PnKdK7NF9V-qx6kp8wg@mail.gmail.com>
 <b1eca2cd-36e6-3a9a-9fe7-70fc0caed7a9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S9VjeYaQHRJy3iN6vjoVjK9IAqSnEf2RZGwgagBkBds=; b=MPOp8iOBlJv9uD
	/yoCM6b4iTgOOTRgVMm/8kXOIH5Oqh31PW10acoSdroRtAV2t/2ORzwV15HD8r3HkgaMsik7Ptz4I
	3zikfHPiibJsjUme7R5AHDV10BXYCTE47cbOdXNzrHpSPyr9ScdDxlfTt5o778vTzvS1sEH2ubfJ4
	2JEfKuaWf0A+UmEOAMXKlvZYEbJtXG0AJEE1Nnsh+9sTfFYBX7O8YpeZwbwztKobz498vdJnswzDC
	ZhXEOdDFzAPCCZFypJz+qTHwiEA2ec7wtYDXFeaVX1RHLJr5fPfeFYgWrKudWm/tqOHRv3s0pUCPN
	nh32lNJJLpUu+ISIqOGQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I1/BTw8u15H3AVnQDepPulkDIkTQG/EDO8JslQ2y518=; b=yzUOmQTC9SehCgZYgd4h+Ey12C
 IF3SwMxqhKSw9mftTnudCgM/6vhgVjqN1K54lqRScHZdWomhMSw8gc4Q17z82/t4ePZPTadPDNBW0
 RAYoi7RTG5lEPYnuj/W83EiMnjCPrblb+04/X34ls5AXk4/1qSt0tzJPYiQCOWZ8wtXGi6o/0W54C
 JYouMTieLlNBty6aTd82+iHFYVBl998jCqSMezXTJKHViIkOZV4L90kAOBr7Bjp+j1Cc20Fo3g2xF
 ZHXM5LboaCYqutYgpLpdk+j1UVvj2hjc2fYOc6snFpF3IOhlr7vydYbVzzsl941esiWGhbWsi5Amp
 qfJLh3Qg==;
Content-Disposition: inline
In-Reply-To: <b1eca2cd-36e6-3a9a-9fe7-70fc0caed7a9@arm.com>
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
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Arnd Bergmann <arnd@arndb>

On Wed, Mar 02, 2022 at 04:36:52PM +0530, Anshuman Khandual wrote:
> On 3/2/22 3:35 PM, Geert Uytterhoeven wrote:
> > I doubt the switch() variant would give better code on any platform.
> > 
> > What about using tables everywhere, using designated initializers
> > to improve readability?
> 
> Designated initializers ? Could you please be more specific. A table look
> up on arm platform would be something like this and arm_protection_map[]
> needs to be updated with user_pgprot like before.

There is *absolutely* nothing wrong with that. Updating it once during
boot is way more efficient than having to compute the value each time
vm_get_page_prot() gets called.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
