From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 34/44] ia64: Register with kernel poweroff handler
Date: Mon,  6 Oct 2014 22:28:36 -0700
Message-ID: <1412659726-29957-35-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
	h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=ECtg6tj+A0PPNJqz/9i7QDAJVbZ2MCBRkRG0jfFaVYU=;
	b=cYbo2lR5IxI47DN5+Y9VzHqD0pXwe8xa+FIyaKWlCzp2pDp2nRsMlBnizHJgJp9wxFLHEaT8/QDmj5H8Y2hU7YIZzMpm8P17ITomvB5TDbLXj3t4b+RqK7Jqg0605FsJJWNxApcbjFCVRy3uvjmTKR6aU4Cwy/7S14bXHFN2yq4=;
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: adi-buildroot-devel@lists.sourceforge.net, devel@driverdev.osuosl.org, devicetree@vger.kernel.org, lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, linux-am33-list@redhat.com, linux-cris-kernel@axis.com, linux-efi@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org, openipmi-developer@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>, Tony Luck <t>

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with lower priority of 64 to reflect that the call
is expected to be replaced at some point.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/ia64/sn/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index 36182c8..6c83425 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -488,12 +488,12 @@ void __init sn_setup(char **cmdline_p)
 	sn_timer_init();
 
 	/*
-	 * set pm_power_off to a SAL call to allow
+	 * set poweroff handler to a SAL call to allow
 	 * sn machines to power off. The SAL call can be replaced
 	 * by an ACPI interface call when ACPI is fully implemented
 	 * for sn.
 	 */
-	pm_power_off = ia64_sn_power_down;
+	register_poweroff_handler_simple(ia64_sn_power_down, 64);
 	current->thread.flags |= IA64_THREAD_MIGRATION;
 }
 
-- 
1.9.1

