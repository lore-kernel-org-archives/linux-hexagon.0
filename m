From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/18] arch: hexagon: Don't select HAVE_OPROFILE
Date: Thu, 14 Jan 2021 17:05:17 +0530
Message-ID: <041ab89e12a71c1bf40d08926c3914c68af1504c.1610622251.git.viresh.kumar@linaro.org>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TktqevA8aRkFmrMbxkkdvPIFhPHaEZezQz/aoRFVng=;
        b=TNUSFgpjYqY77U3gHE2sLGc/y6BYcTK8p+HT7WVOwP7WSCt01u5I0UNjyaBQvJ+HiI
         nCDVv7XvnNyX9yNXGluQsDOln7AewWmnUc+5rE3sHdyhCLcxSg/akxlIT/0MPvP3jaoc
         uq71J03wV2VT1Igm2NIYqz+GT2JesUb6j8+38zYAn3Vfk+tSSP8nP7e0uYiV1AqleAd2
         aeRNSZBfK0x6S1zdK2wsd4M8cMs6s1lscVtIO8creMkqzHCr6vNR7wAaMQ6vsMLHYHWC
         v1OuT3Pk4uMAp8MGVyWWnvfByGZxQVfI9foicND7QUOOs7tqE4crjxsJ/sCVdC5GjC1X
         bZCw==
In-Reply-To: <cover.1610622251.git.viresh.kumar@linaro.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>, Robert Richter <rric@kernel.org>, Brian Cain <bcain@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net, William Cohen <wcohen@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

The "oprofile" user-space tools don't use the kernel OPROFILE support
any more, and haven't in a long time. User-space has been converted to
the perf interfaces.

Don't select HAVE_OPROFILE for hexagon anymore.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/hexagon/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 6e00c16a36b5..44a409967af1 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -7,7 +7,6 @@ config HEXAGON
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
-	select HAVE_OPROFILE
 	# Other pending projects/to-do items.
 	# select HAVE_REGS_AND_STACK_ACCESS_API
 	# select HAVE_HW_BREAKPOINT if PERF_EVENTS
-- 
2.25.0.rc1.19.g042ed3e048af

