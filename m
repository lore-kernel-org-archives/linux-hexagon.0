From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 06/13] locking/bitspinlock: Clenaup PREEMPT_COUNT leftovers
Date: Mon, 14 Sep 2020 22:42:15 +0200
Message-ID: <20200914204441.579902354@linutronix.de>
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
	 bh=1qBNIe3NCr3W4qkVBiGg5hg54bMkW/edzTN+4q0s/do=; b=s8L/Qk/vT366VP+tseKR6W56N
	vT2LzswbhzIo0sjW06WIr6lLOgy1iEWZliNO+9UB7IbpnxHkQkk5BiJiRqg0s/AR1dwRLjUj+0XYB
	v5Lf+iHe5Koiun58j2jKIEgVOhbEtzvaWavWY1ev5iPjWasZ+sRZh6LA0N325vyQxYeJJk8LqFWm3
	5rYDaGEwpX3ukcT2/cCfcJXtLcD8RQmw1BaNdsU6zCIYyzbWgAb+5qVn/kv4pj3Zd6zS9vySaxxEU
	h2677zHtZ6l1SzfdULJ26XM9lGsFiqhifRpbAN6Dp0fPR+TUkIRpww4Hq2Ajucf8VykHPKQqQjdft
	Z8uhKev8A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=jSFTo2fNR1Fdj7RHwVSUWdICcz7BXx9GuxCsTljfBDc=;
 b=RL+GkltuYzZCWy8Cl1LjhwVE2UJSR7gGP8TiZHbtSgQnmRdyXbIOVVanHwJJVoDlIcYY5Q
 LT96l5PoSA374gjRYkYij/UgBBRwAsUNJA27/lNUFgAab0YxBGxg+IQGVFDp6i0sbydVRc
 IgZYFrlBf+xwTJJ8aV7qkci3qtWFLu9LbGCA31a69ZP2uifgnP2luS1nAIav4nxaYCJEkQ
 BaAeIICjaUsuG+G/c/xCj5ieBqIiGoaPVVF7QnE/PLcdRXu4uEgJ+t+EnJKscI1HXpkBnh
 uVgfLl8V0mb6gBn4Ey5eVzZRinNAX/sDY29X2dWyf7b2WPCGws3FVkfELbK5XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=jSFTo2fNR1Fdj7RHwVSUWdICcz7BXx9GuxCsTljfBDc=;
 b=iut+FC9xX/+WwHylk5Bo+ib2vZPOOOfiQ/k306Td/lwmjp/fN6Nz77KXB6ZCuxjuePB6sn
 U5e1M/wY5OUVmsAw==
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

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/bit_spinlock.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -90,10 +90,8 @@ static inline int bit_spin_is_locked(int
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	return test_bit(bitnum, addr);
-#elif defined CONFIG_PREEMPT_COUNT
-	return preempt_count();
 #else
-	return 1;
+	return preempt_count();
 #endif
 }
