From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] arch: remove redundant generic-y defines
Date: Wed, 5 Dec 2018 06:44:38 -0800
Message-ID: <20181205144438.GA30692@infradead.org>
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
 <1544009286-15705-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J36lbgMbxb84VTNM/HxCPmEIhANJ9Lhj3BdaZVqK26M=; b=VU21WjcnoCUoa7
	ZN39rd89EkRyZ230oPJowZXmqibDkX9wyPFnUlmO4ZLFrcLl/IG0RmNRnTBB1CCQVopHDA57TQX2h
	h88e1ypTdek4qkpzci+G1D0JryNVFnW7eA+Fcudk8V9DlEzrgoGWvzI5/htKRVBG5Vm0me5pOw/aA
	mEJ6CriZhNxn4eAEcQ61bKOilL7FA9nNkTRMcEHxsg/Jqh3972gDxP+KCU4X5rJX3tFjNEcO9FDmK
	vxFo11E7xOMXPMOZG8Uhom3Br3yONwvHwxrizf5bFlxCZT4UJ6fGM+PXdUGHqx9pGFJRtTBfeN2VG
	YQjJqNOVfsLLTdEjRmTw==;
Content-Disposition: inline
In-Reply-To: <1544009286-15705-3-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, James Hogan <jhogan@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Max Filippov <jcmvbkbc@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Daniel Borkmann <daniel@iogearbox.net>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, In

On Wed, Dec 05, 2018 at 08:28:06PM +0900, Masahiro Yamada wrote:
> Now that Kbuild automatically creates asm-generic wrappers for missing
> mandatory headers, it is redundant to list the same headers in
> generic-y and mandatory-y.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Oh, that is very useful, especially as maintainance of those
generic-y lines has been a mess!

Acked-by: Christoph Hellwig <hch@lst.de>
