From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH] hexagon/time: set ->min_delta_ticks and ->max_delta_ticks
Date: Thu, 30 Mar 2017 21:43:32 +0200
Message-ID: <20170330194332.6915-1-nicstange@gmail.com>
References: <20170326134403.16226-1-nicstange@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ygKoKTbS2rGWQMCFrKFBCJCieFiuuapLzBLEWhL3QUM=;
        b=hGGoLNUFnmVHvXPNC1EPKCqRngHS1kx1/1WNi5yYZw/0tpvzitOMkqllf0V6o3fvot
         oSNM/kXJBDd7g/YNQZWT70slw0OF5FsZSDj86lsYUd+uDHdJhQTb8CziqkNjVCZSQ7h7
         tmV+7L2h796NcehReNw790rX4RvKjSZogOaZDP99vCLk0eWgaMqerRiASp3NYx7uEmPg
         mOEfL2R/+kEKBRQGEFzPFlx/9W6Dp4cyUU51hMI+MrhW/XI5xjOEmuSDBvky7AgSaKQ5
         ORB1rJpWriC8oyXCgh7oqtjR+e/vactXUVDv1TABgb716qF4zZnTAikASJLZb2PQaO6X
         a36A==
In-Reply-To: <20170326134403.16226-1-nicstange@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Nicolai Stange <nicstange@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-hexagon@vger.kernel.org

In preparation for making the clockevents core NTP correction aware,
all clockevent device drivers must set ->min_delta_ticks and
->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
clockevent device's rate is going to change dynamically and thus, the
ratio of ns to ticks ceases to stay invariant.

Make the hexagon arch's clockevent driver initialize these fields
properly.

This patch alone doesn't introduce any change in functionality as the
clockevents core still looks exclusively at the (untouched) ->min_delta_ns
and ->max_delta_ns. As soon as this has changed, a followup patch will
purge the initialization of ->min_delta_ns and ->max_delta_ns from this
driver.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---

Notes:
    This prerequisite patch is part of a larger effort to feed NTP
    corrections into the clockevent devices' frequencies and thus
    avoiding their notion of time to diverge from the system's
    one. If you're interested, the current state of the whole series
    can be found at [1].
    
    If you haven't got any objections and these prerequisites get
    merged by 4.12 everywhere, I'll proceed with the remainder of
    this series in 4.13.
    
    Applicable to next-20170324 as well as to John' Stultz tree [2].
    
    [1]
      git://nicst.de/linux.git cev-freq-adj.v10.fortglx-4.12-time
      https://nicst.de/git/?p=linux.git;a=shortlog;h=refs/heads/cev-freq-adj.v10.fortglx-4.12-time
    
    [2]
      https://git.linaro.org/people/john.stultz/linux.git fortglx/4.12/time

 arch/hexagon/kernel/time.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index ff4e9bf995e9..29b1f57116c8 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -199,7 +199,9 @@ void __init time_init_deferred(void)
 	clockevents_calc_mult_shift(ce_dev, sleep_clk_freq, 4);
 
 	ce_dev->max_delta_ns = clockevent_delta2ns(0x7fffffff, ce_dev);
+	ce_dev->max_delta_ticks = 0x7fffffff;
 	ce_dev->min_delta_ns = clockevent_delta2ns(0xf, ce_dev);
+	ce_dev->min_delta_ticks = 0xf;
 
 #ifdef CONFIG_SMP
 	setup_percpu_clockdev();
-- 
2.12.0

