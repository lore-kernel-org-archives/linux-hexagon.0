From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Date: Sat, 31 Mar 2012 13:25:02 -0700
Message-ID: <4F77681E.5010608@xenotime.net>
References: <20120331163321.GA15809@linux.vnet.ibm.com> <20120331201500.GA27640@linas.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xenotime.net; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=fQvDRtvb5qaSxJ8hdf1WmrM7Zo8pFWHi8X8HBanaV90=;
	b=cWCyQa3IefoXxnWRM7oiyGCzVjO6FPXWkYfk8EAlU6JDuHjFGH0wUi5XqonAc5l1etCHYoNVCGm8bmb3LBrfry3U5G5P2GvFU4fcw9YtF0v+HnH9jBW0hYv76n/kNORr;
In-Reply-To: <20120331201500.GA27640@linas.org>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linas Vepstas <linasvepstas@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tglx@linutronix.de, linux@arm.linux.org.uk, dhowells@redhat.com, jejb@parisc-linux.org, linux390@de.ibm.com, x86@kernel.org, cmetcalf@tilera.com

On 03/31/2012 01:15 PM, Linas Vepstas wrote:

> 
> Hi,
> 
> I didn't actually try to compile the patch below; it didn't look like
> C code so I wasn't sure what compiler to run it through.  I guess maybe
> its python?  However, I'm very sure that the patches are completely
> correct, because I read them, and I also know Paul.  And I've heard of
> Thomas Gleixner.


x86_64 defconfig has many build errors and warnings.  :(

back to my abacus.

-- 
~Randy
