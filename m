From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch v3 17/36] Hexagon: Add interrupts
Date: Fri, 9 Sep 2011 15:04:58 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109091502571.2723@ionos>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.327107063@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20110909010916.327107063@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Thu, 8 Sep 2011, Richard Kuo wrote:

> Removed init_IRQ wrapper and fixed up some comments.

> +int show_interrupts(struct seq_file *p, void *v)

Please use the generic version of show_interrupts.

Otherwise please add:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
