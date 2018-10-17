From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Date: Wed, 17 Oct 2018 09:38:16 +0200
Message-ID: <80a7d851-51ca-2d81-1273-393d4f701bc4@suse.cz>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181015094209.GA31999@infradead.org>
 <20181015223303.GA164293@joelaf.mtv.corp.google.com>
 <35b9c85a-b366-9ca3-5647-c2568c811961@suse.cz>
 <20181016194313.GA247930@joelaf.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M/7M93cqGpe2GzhvGWRPIWtgqB9bH0aNC1buIqpkdaU=; b=iU8IgMR3h/CNwX
	Eg0y/DVoRMm05qDtpXpj5cOahbST6Bx3acr7GJexLwoGfxiZ0BAte8p39mfsJtMCoFYYH4cuiT9m1
	WhvagiUraRkD0M4r152NOxQEuwCyybrgDNN3Bc19lYtmw2JoIlOVvAz1PvbP4Rf9Crd8AZPuE3+HT
	WFEvmokx5bNfnsXcKZyf+dFUCokuGiEJKPSoYSmBrxTpvE8NTat3Ieg27Jvr3L6PyrKXTAcYmdwVK
	zDIa/d7CioTMtCii3t9WcxFn4OXX5zYtVv8bPNyJEGm/UiC71mtVHeD+9tIMgtG8RjE9X5lcQEoSS
	Bh0so2I3MS/qr2TJk/bA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dP2hYsi47y7itSQr27wjgFfh0Y8hXr45ZP8z9XgAJvY=; b=m5EEejps8Qt0gQFRaXC0fFrU64
 foGBjLb6e+quCyJduogh5bshjTPy6R3c+sZVq190KJ9NnrpH21AwGaayMDd03pAey1DJLzRMzLbZN
 5hpRBgF88vMuLle857BQxSZplRAiz3gEZyfCtz4ji1XaM06H0/qJjBb4GFXE27aexWYk7zW2Jgc+z
 jovIxkVLvUy44VUKgjdy02sJKboVFrplLRc4qKPuHj384BRVUn+T2EYKERoFkiF9vimE2uefpmOcn
 VD45JTk8JnMxNtyWx6K0MK4qMgybOgTZjGyaxe/p5OxpOUdkZ4z2uEdhFTZefjqojLsbOyAMYkfPb
 l/9XD5bQ==;
In-Reply-To: <20181016194313.GA247930@joelaf.mtv.corp.google.com>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, elfring@users.sourceforge.net, Christoph Hellwig <hch@infradead.org>, Ingo

On 10/16/18 9:43 PM, Joel Fernandes wrote:
> On Tue, Oct 16, 2018 at 01:29:52PM +0200, Vlastimil Babka wrote:
>> On 10/16/18 12:33 AM, Joel Fernandes wrote:
>>> On Mon, Oct 15, 2018 at 02:42:09AM -0700, Christoph Hellwig wrote:
>>>> On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
>>>>> Android needs to mremap large regions of memory during memory management
>>>>> related operations.
>>>>
>>>> Just curious: why?
>>>
>>> In Android we have a requirement of moving a large (up to a GB now, but may
>>> grow bigger in future) memory range from one location to another.
>>
>> I think Christoph's "why?" was about the requirement, not why it hurts
>> applications. I admit I'm now also curious :)
> 
> This issue was discovered when we wanted to be able to move the physical
> pages of a memory range to another location quickly so that, after the
> application threads are resumed, UFFDIO_REGISTER_MODE_MISSING userfaultfd
> faults can be received on the original memory range. The actual operations
> performed on the memory range are beyond the scope of this discussion. The
> user threads continue to refer to the old address which will now fault. The
> reason we want retain the old memory range and receives faults there is to
> avoid the need to fix the addresses all over the address space of the threads
> after we finish with performing operations on them in the fault handlers, so
> we mremap it and receive faults at the old addresses.
> 
> Does that answer your question?

Yes, interesting, thanks!

Vlastimil

> thanks,
> 
> - Joel
> 
