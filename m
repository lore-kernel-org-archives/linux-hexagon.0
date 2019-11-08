From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Fri, 8 Nov 2019 19:37:19 +0900
Message-ID: <20191108103719.GB175344@google.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/TbfvbBMMqYJhaiiDLT5hNlGfQ9AYI+qFDv44qtxUn8=; b=ev1AOwJFzwsuKz
	KReAxG09UHfg38wG4XRZOHXjGaMk/Fey12D2/WiOJEBAMFBnkMFH8M6nFVSRigk2V50gJTBa5ox8P
	hK7A/SRq/Yh5MjFhzsOZ1kneLnxnZXD/eCPO3b/9OA0Ug0pF7B8B7m8+E+6bh4x7hbcOBiy+5cZFU
	S4f+1ptRlURf91kNyJbmhqyiyDYc5+8pUPzLb1zjJx65sakMqCxmywH/eNa/MxUZI/vpoYKmLiPC5
	7pzjWHdw8m8wBtrXrhyjPNntHGhRwXZwJQooYVKMQ3Pzv4JwLofpguhkmRU4bl8o1Ct0elLuHQshs
	OckqDG8vQ/DBS+IykC+w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=S+Nia2Oa5QzCO5JT/esBQ1livkv4TlWV+4fZRWkEO+o=;
 b=f9fUi1K0epILaPpMKUGA+FGIJ+GYnQXz31FR/JIRsr0jNtvXVD8WKS6AKbo2g/yYiS
 jp2Jgic4IxPn6T+PZphyltIyB4vnkBFwniOcMw51O2csFX1kjAC4QKejH96MUOsdWVPi
 BoIKRt+J7TT0AysruvIMXwSoJkxw5mAFsb1iShx9yrdJQ4jAMH1x3fQmLCILPy17O63N
 P5MCDaBbfZ4mb7y00oRdGf9IW4tz0D1nAGsSM5DLvdeQEZfjNAjb8k+88kSyJh4+WTH8
 CfsXzxfWKj+ARiV2OGLJRKeQ2vRNt5PSY65UAb+0sRHT/5MlGv9E/r9lKer8LjaXODrM
 kWIA==
Content-Disposition: inline
In-Reply-To: <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Dmitry Safonov <dima@arista.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kerne

On (19/11/06 09:35), Petr Mladek wrote:
> I agree with all the other justification.
> 
> I would add. The backtrace is really useful for debugging. It should
> be possible to print it even in less critical situations.

Hmm, I don't know.
Do we really need debug/info level backtraces? May be all backtraces
can be converted to something more severe (so we can stop playing games
with loglvl) and then we can clean up "(ab)users"?

	-ss
