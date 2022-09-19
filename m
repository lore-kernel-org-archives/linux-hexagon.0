From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 40/44] ubsan: Fix objtool UACCESS warns
Date: Mon, 19 Sep 2022 12:00:19 +0200
Message-ID: <20220919101523.043382530@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E16336FB9B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A6796FB82
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21970416FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA2D441712
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=G+s8KeYPo3DKU8KAsFzI9EuTHpElgTPxlXfQAuxRCYE=; b=EFx7B8LZTc83Pl4WaazbOvooxh
 m5ZH43lt/bUlEN9jEiueLap+B4d87w5iLtoW12OfYwc57bGORzfANspx7UladbBmGSWc1xIqbuqIn
 FOYYsmRFy+hGwvwvJke8Fb32oGMOnwwKJRBjXTd62rAreByaRoia5cby7KftFCJ5X/Ml7ELcrwj5J
 eiKKDdHS7VBR9PkXXj1rPKGhThK0lQvF5JDGcSZD67Indcxu2z2DcH6Nt3bnOKQDsnf0QQZKS0PCq
 ltrSo2MfjxxanO8+19FzwsNyRAZqAIM7DEPtfJ6dxj7PDwKMiZ9L9kurxNJZpN7RIUHFgemSiXBCp
 JnN7XVag==;
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: peterz@infradead.org
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org, Andrew Morton <a>

clang-14 allyesconfig gives:

vmlinux.o: warning: objtool: emulator_cmpxchg_emulated+0x705: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
vmlinux.o: warning: objtool: paging64_update_accessed_dirty_bits+0x39e: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
vmlinux.o: warning: objtool: paging32_update_accessed_dirty_bits+0x390: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
vmlinux.o: warning: objtool: ept_update_accessed_dirty_bits+0x43f: call to __ubsan_handle_load_invalid_value() with UACCESS enabled

Add the required eflags save/restore and whitelist the thing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/ubsan.c           |    5 ++++-
 tools/objtool/check.c |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -340,9 +340,10 @@ void __ubsan_handle_load_invalid_value(v
 {
 	struct invalid_value_data *data = _data;
 	char val_str[VALUE_LENGTH];
+	unsigned long ua_flags = user_access_save();
 
 	if (suppress_report(&data->location))
-		return;
+		goto out;
 
 	ubsan_prologue(&data->location, "invalid-load");
 
@@ -352,6 +353,8 @@ void __ubsan_handle_load_invalid_value(v
 		val_str, data->type->type_name);
 
 	ubsan_epilogue();
+out:
+	user_access_restore(ua_flags);
 }
 EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1068,6 +1068,7 @@ static const char *uaccess_safe_builtin[
 	"__ubsan_handle_type_mismatch",
 	"__ubsan_handle_type_mismatch_v1",
 	"__ubsan_handle_shift_out_of_bounds",
+	"__ubsan_handle_load_invalid_value",
 	/* misc */
 	"csum_partial_copy_generic",
 	"copy_mc_fragile",
