From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Fri, 15 Nov 2019 09:50:22 +0900
Message-ID: <20191115005022.GA144607@google.com>
References: <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com>
 <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
 <20191112101229.GA201294@google.com>
 <20191113012337.GA70781@google.com>
 <25ff45f0-6420-f660-55a8-637f11ab5ab4@arista.com>
 <20191113063334.GA147997@google.com>
 <578d041a-3ce5-28bb-9fcc-cf90fe82b036@arista.com>
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
	List-Owner; bh=QWTME4UeO86YGBHAcGZfZ8AbkTifUsmhER8A2kYsmFY=; b=ZcVzw/7K3zeT2T
	8JbySmWIcMOzUPViSv/mBCkXeK5TqP4/YGqPXxvJhwdnQwc6Uu5BhumjBzqZxYg9whFY5QHuI4Of/
	t0S7sAZrB1ABTQ50Ci/mpi2sHUIJMVMDWpHgoadXOQHEKL7fJB6tvztLZHEIQirkrzxUAlxv/vZXF
	YCv0ggWvREz/B6elGffnuXoRx4qcr2rJ+69Uz7Jw65GceVHh1AYYsbyIaPeOhUUI1gmaOve3iI1KN
	zlcGi+jYXJk1I2i09GzOKsOBzg/CRyVpc6G2ufP9Ut0U64k1bD+GoVtOYzpwnXgZEn4k3GmU4Mis7
	/9E9ivriChG/7o5+gAZg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vPNtAsB3gXKxK0gWaPZBn5Rp3HfCqb9+MUmX4aWZ2D4=;
 b=KmyV0wmxO8hyWXeEcxKcQ9g8HAkhA/qdNPNsFVQfn2yQQaw88HTfL9LaYbMztbfLd7
 52Pu0wZdSH5VQCaovxyvQHk0OD3K8hwyJyv7gTIE7WfYFbfnBk0EdgJX1JDN4pxqrXgl
 ySMbute8meJ9NzhuhL1SAlrw8K7mPUp5drSPhW4XMcf1d4qZgHVwU+2rw50XjdktNSiF
 sXgm7kRa4irKvcghjdz42mh6HHtDdUpm74owHzVgf/ujVAH0IqCxtLXrybdOBUMLjKyu
 aagzgO7oGkNhda1hCKKFnixzMGqDsMvYc3bCAGLjTVnTtVkSC3NSs1N74SaX4ygndQ54
 O+dw==
Content-Disposition: inline
In-Reply-To: <578d041a-3ce5-28bb-9fcc-cf90fe82b036@arista.com>
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
To: Dmitry Safonov <dima@arista.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Petr Mladek <pmladek@suse.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwyso>

On (19/11/13 16:40), Dmitry Safonov wrote:
> It's also not very fun for me to create those patches.
> But they fix console_loglevel issues (I hope we could un-export it in
> the end) and also I need it for my other patches those will produce
> warnings with debug loglevel when configured through sysctl.

No objections.

	-ss
