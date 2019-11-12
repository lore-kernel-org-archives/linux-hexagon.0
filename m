From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Tue, 12 Nov 2019 19:12:29 +0900
Message-ID: <20191112101229.GA201294@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com>
 <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
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
	List-Owner; bh=q+Uh6YsrHi5y6Hz5Eq5MDIWDwCL1pI4/JD98rAJdG9A=; b=Y3ukFV9f4i/BYD
	jX8lm9SyPrjmEYXsS0MBSWdqJCU/Lbj6j8M5lqST817x4v3q3kvHIDnk+7g+Z1yBqict555zKKyP9
	fbaF7imeOMguXE6VtQNTm3k1pw8grgh/mXMi/fyNE5nzJt5hOPhMB+mDXZ0Oxb5F0HQOQJAiWCwpL
	jUX47yH7TaSrEjpZ3aub+Ts75IiLWWreT2cCW9gRkNeQSNK5l9a2oVcLqE3FD6NgxuJRtpU5PXTQC
	Y7EBADmCJl6XhFF7ofJoUHDjnLhwJqvRD46m3E0zcrdTdQZcbVhrNE7Vny1pJOVkrCE5vLCMwsZyX
	n73GWWZSFtqKqoekGu7w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iABlNrF2pKWSZ44AJQZkuRtZU/cPi9wpLdONGxReYeE=;
 b=lVQpY920ERl+suupN9XSt5AI00c2Bwp6YTe+nuAxfJ0tx8/CHdvsOX8KqHu3FmMDHw
 pKJz2qZ3MIZdI/LvHcuOQwnw03zOL+xBaPoBM3Sk8cqEAObtva+w2W+VwUQXyt+Yzl0z
 2Ik5jh60mk6441pRqx3/IONqYdeiU8UBQPNLpaFQv+9/cOgrSL80TVTu8IIfCepoYN0k
 46xEtzM2XHEzQhHHKxX5sVHiAqwMvF9Sq45W8ZvBkd56VxLaVtoM4UNEcrlWR3NAHdQy
 xhQtHdonv/wnGP9QHISUJ1hs6f5eymrLlJUCAqXrERs33xe9PtMv6394ZI1rErDw09YV
 v71Q==
Content-Disposition: inline
In-Reply-To: <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Dmitry Safonov <dima@arista.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.or>

On (19/11/12 09:35), Petr Mladek wrote:
[..]
> This is getting too complicated. It would introduce too many
> hidden rules. While the explicitly passed loglevel parameter
> is straightforward and clear.

If loglevel is DEFAULT or NOTICE or INFO then we can overwrite it
(either downgrade or upgrade). That's one rule, basically. Not too
complicated, I guess.

> I am getting more inclined to the solution introduced by this
> patchset. It looks reasonable for the different use-cases.

No pressure from my side. Up to arch maintainers.

	-ss
