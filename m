From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: (subset) [PATCH 00/17] -Wmissing-prototype warning fixes
Date: Thu, 24 Aug 2023 21:12:49 -0400
Message-ID: <169292577153.789945.11297239773543112051.b4-ty@oracle.com>
References: <20230810141947.1236730-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w1vxIICUrglFAIpXe2KIgHiR2ggyFU/dBZ3mh7xQFTc=; b=SzEO1Ox7Fyszhl
	so96q0niGMpFeR0+MQmJzKu9nrdN4pTQuO6Bu6fpytm4MFgls8+RBnW+49I/JO4ZJ1Qi7sGykEJJ4
	mNkKfLgWY83o48L2XJb4cDtJvuPOfCT6wJ/m2dUQwbP/BIfPFx5eCLHdiQaNlB7CtR2o5x5wQ/aM9
	BgzryKIM/doqzW04Z6oF0tLyQyZ/DYmHnwv07wdjzy8p1BE0sp+oR7/thylqmRW5PT0wdvt3IHG5n
	pA0kKHS5IYrciyQgri8RU+D/lfI7lhwBsOtK22RrYupDIXl4oaBT9su+Bxw1TMWn0ZcB1HAB7A2Bn
	4nsGolzY4IGTPWOjYj7g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=uhEjckime6bsF1xq0dmnY+LwEHiDmuGwjHJQ7hVpFpk=;
 b=xT4JwIyBXmmvopnLoTqXTVQDIyq4jGSov+rjFGn7JrEsFJ0nGwiZ57rChZOcNtxS8gnd
 32i9D/0gBNdAu6wmrSv4Tj5XGTtiOMTcrD7d8d7sIx9zu+UBUHmYA/WieiP0xKAeu3gF
 eHe1MsKPNrAZDzygQo0FmmEXELlSaZ2xMctwoLvlgndq1xchpQqBIi92sT4g6z/NC03I
 Sq45+sJdryY0Xt3UtsdNEeUPJQQwXRC0pKx/6zSsrk8N0z228cv46+9188htxHxgrJuH
 O19AK6RPcqphkoDDRpvAZZx3qvPOulLbxkXwvTBtVM7s38ELpJEo9mWBxT45N4g00a45 fg== 
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
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
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael

On Thu, 10 Aug 2023 16:19:18 +0200, Arnd Bergmann wrote:

> Most of the patches I sent so far for the -Wmissing-prototype warnings
> have made it into linux-next now. There are a few that I'm resending
> now as nobody has picked them up, and then a number of fixes that I
> found while test-building across all architectures rather than just the
> ones I usually test.
> 
> The first 15 patches in this series should be uncontroversial, so
> I expect that either a subsystem maintainer or Andrew Morton can
> apply these directly.
> 
> [...]

Applied to 6.6/scsi-queue, thanks!

[07/17] scsi: qlogicpti: mark qlogicpti_info() static
        https://git.kernel.org/mkp/scsi/c/71cc486335c4
[11/17] scsi: gvp11: remove unused gvp11_setup() function
        https://git.kernel.org/mkp/scsi/c/bfaa4a0ce1bb

-- 
Martin K. Petersen	Oracle Linux Engineering
