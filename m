From: Yang Shi <yang.shi@linaro.org>
Subject: [PATCH 4/4] h8300: set DEBUG_KERNEL in defconfigs
Date: Mon,  9 Nov 2015 11:21:18 -0800
Message-ID: <1447096878-13519-5-git-send-email-yang.shi@linaro.org>
References: <1447096878-13519-1-git-send-email-yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro_org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sKxpyCLJ7rMgaSps7UpPAynPRR7/BGaBvpPRipz87TY=;
        b=LNqDUElrRf9fGfJX3LUlcT00agCwhc3qAJX7d98uIbTEJQTvoDI7LgR0TPU5hKMR9P
         JN8CuVI1rq0/Xi+OzhHVq4P8f0l7PDYnX2WPuGLkXIxvNyIETcwEEoR7BBqeMATQo9qg
         U2po23OXjw7tLg4xLQbadPZPIT/0d7BKONxQEJyV9VckEkyXeXCnhAJy4ahjnNPNAl79
         ZEIAVy/bVfPa7WP48ku9kSr7aMNxAiomAEIV++FQAebGK4fBcYev5yNxLyUu6abZr5OU
         8HVWRXrybctt2GLtofKOEqSXAIcHiGXCQST0qUKqOqK/H0/8MRAN+Hi6quxMj5SEpo5X
         Orjg==
In-Reply-To: <1447096878-13519-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp, ysato@users.sourceforge.jp, hskinnemoen@gmail.com, egtvedt@samfundet.no, linux-hexagon@vger.kernel.org, rkuo@codeaurora.org, mingo@redhat.com, yang.shi@linaro.org

h8300 has FRAME_POINTER selected by default, but it depends on DEBUG_KERNEL,
so set DEBUG_KERNEL in defconfigs.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/h8300/configs/edosk2674_defconfig  | 1 +
 arch/h8300/configs/h8300h-sim_defconfig | 1 +
 arch/h8300/configs/h8s-sim_defconfig    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/h8300/configs/edosk2674_defconfig b/arch/h8300/configs/edosk2674_defconfig
index 29fda12..f497cb1 100644
--- a/arch/h8300/configs/edosk2674_defconfig
+++ b/arch/h8300/configs/edosk2674_defconfig
@@ -47,3 +47,4 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
diff --git a/arch/h8300/configs/h8300h-sim_defconfig b/arch/h8300/configs/h8300h-sim_defconfig
index 067bfe9..0b80883 100644
--- a/arch/h8300/configs/h8300h-sim_defconfig
+++ b/arch/h8300/configs/h8300h-sim_defconfig
@@ -47,3 +47,4 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
diff --git a/arch/h8300/configs/h8s-sim_defconfig b/arch/h8300/configs/h8s-sim_defconfig
index 29fda12..f497cb1 100644
--- a/arch/h8300/configs/h8s-sim_defconfig
+++ b/arch/h8300/configs/h8s-sim_defconfig
@@ -47,3 +47,4 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
-- 
2.0.2
