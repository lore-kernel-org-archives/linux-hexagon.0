From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 13/13] preempt: Remove PREEMPT_COUNT from Kconfig
Date: Mon, 14 Sep 2020 22:42:22 +0200
Message-ID: <20200914204442.314368657@linutronix.de>
References: <20200914204209.256266093@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Subject:To:From:Date:
	Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=1xk/NcikOiulToWGA67ytvVfsNgeoOqPXfHdcS8b5e8=; b=iJE/QcMu8UpZQrM2JkpDeVuzQ
	Ts2OjoOSJAqJYqVou9mUhqEjg7hzzortNIR619LqEcTvLNo9kBcSleCXdgervxcszM7U3slu8UG94
	UpT7ATpCZfqEh/9sXiMkmH3xFNr2BKrLryTO0IHocBBg7R5TNFNDLt4jURx5VQzfwwdR0tHqjBMkc
	dGEL8DFpuIAvjxPIVV71GbdHbNYsd3vSbsTcYlGB6IylO9x4I6xmEVvCDj/OOh2PFU2SRRchZbk/1
	TFwHWiJgveyNK6MaujWUuaaH1esvCztsHMYYOzZdyMfsKP43TsjUjTAk7HzKNY0AMO87ByVekTmVK
	iamxGyzHA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=UaGFOx0lyNqbbywQXqvyvs0Y1K9lyW/4pia2fj5ZPrE=;
 b=LxVyssknLcIiK22e1VzZnztccpsvkjdmrlVivflVkb4m1ZrwdN3AJS4QHe2LRYerp90sAJ
 FBZoG2DfwbQyLh5+Je5k/MOKeTYBT9SxeXDAhVqSBFBtR1mPa8BkvdixL/Sl5PWnW+y1eh
 nx4wWlDBVQEky22eNZaKPVElhVOK81QF2qRuZvRM79l53oBJz4vrn8mh1ykUaNmr/A/XJ9
 iq96UI512gRnF7NnxMcXKGgpryjbDZ6Pv1B01aOcw47VTkiTw7inicM9yMZTycMZiF2Nyx
 JLgS4ixXfvGGE0BMGRuO7hVX609SwmYqDeG9Kt0vRFcwibvKMCS37rg3W5/NbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=UaGFOx0lyNqbbywQXqvyvs0Y1K9lyW/4pia2fj5ZPrE=;
 b=l6KC1ghexQ/0a3aTO9H5kyQ+7ci5UCAGhzmXb+6nRV31u8qCgTIRNqW5jsSza0cUPDZdAV
 vVRo/rJwEu10BBDw==
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel@lists.freedesktop.org, Ben Segall <bsegall@google.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>, Valentin

All conditionals and irritations are gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/Kconfig.preempt |    3 ---
 1 file changed, 3 deletions(-)

--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -74,8 +74,5 @@ config PREEMPT_RT
 
 endchoice
 
-config PREEMPT_COUNT
-       def_bool y
-
 config PREEMPTION
        bool
