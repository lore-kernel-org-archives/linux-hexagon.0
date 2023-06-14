From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 21/34] arm64: Convert various functions to use ptdescs
Date: Wed, 14 Jun 2023 17:41:30 +0100
Message-ID: <ZIntusCSpsSHISYp@arm.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-22-vishal.moola@gmail.com>
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
	List-Owner; bh=z9f/qep4JJydoXCmV70en8O4KxvRkRTlOm7Wpc6F/v4=; b=B/cc169KGJ4R+h
	GzIRyDAKoaRrP9h8+0cyI0S7RI7xSJaXAVdV1PvJxybunCrJhnxwLI0aDNtq8PRm4eIKsRU49FjNE
	jg7i++93t4nYG904vXzsWVPmRPVVV0eCYwv691HT9aj1PjCXB57GE6o7IH2wbpiLfTwmHyNOZdB65
	iKt/sAk+HBOl4h3DEe4YGSIHtiXK4uJUq+yZBI86/PjM/lYzXzEdI6cCbntEUrVQykU4oLNilVPFc
	UgskDrNEbqFBnC/cD6Foh0L84cyw2fliJQnUKYmmzXPVYACSXiqfffz2eFJh7IjNn0N2Z7n1nXpPs
	QE+6Q1e5vXEx3SxPc3bQ==;
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-22-vishal.moola@gmail.com>
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
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>

On Mon, Jun 12, 2023 at 02:04:10PM -0700, Vishal Moola (Oracle) wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
