Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E53D16E2;
	Wed, 19 Aug 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121122; cv=none; b=lKh6+eRWfr+jy7UcDp590Cur74Se7ncpNZCoCThU4rh41u4RdxaIzlTKYHarDTkW4GdIvcxhg1HyyQyZaJYDr38SFFZRCgfVgYBakZj7HvJVUvHmi58Ab0+7gyd3v4OTU+z2nAF/T60oiUGQofBzAv2U0YYGmWIkdhJ6oIKhST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121122; c=relaxed/simple;
	bh=1EKQ0vma0RFWhPJizZPAaqpdxg6Ql4yO7eDuDs08Ylg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/KHgmYYaPKNQV9KNqxix0Dn4p+dDs1qIqagRYQ7h62zbo1MWfhPj4WOFCKwxQin9Lck10rLS9GTrfE0TI3Qj/YgxHsMciec0/serbQje2jTvLKiWio/yQ3S0J9aGZgfOcSL/T1uwJ7g3skMZW2LgqE57t4s7fe+YH4nm8fC6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EYX/hxNL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EYX/hxNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1787121118;
	bh=1EKQ0vma0RFWhPJizZPAaqpdxg6Ql4yO7eDuDs08Ylg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EYX/hxNLFEcSQDIERAyFFLy3lH+5X5cUeq0KKVeQANM5IHu3aY/+fhOnn4Qytt48x
	 MECisRKzscv63lr90cfaGsD9FE+7X22XrNkQukT4oWzYyRzT7d1Kwy7yOR+KtOR/1I
	 PUGSjJ6LHALG5CUKU8jvsCv+bfOoiHYKpT13odZU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 19 Aug 2026 08:31:52 +0200
Subject: [PATCH 2/3] selftests/nolibc: prepare for clang-only architectures
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-nolibc-hexagon-v1-2-6bc3be591f09@weissschuh.net>
References: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
In-Reply-To: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
To: Brian Cain <bcain@kernel.org>, Willy Tarreau <w@1wt.eu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787121117; l=1830;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1EKQ0vma0RFWhPJizZPAaqpdxg6Ql4yO7eDuDs08Ylg=;
 b=nWvHzVxyVY4C/J0RaB6Z7vNnijwaFoSfmfDeewJLfgxXEAwZpvDIg9E6A3OaDtnGgaglGJFi8
 aKVt8Ka8AcjAIMRtD4TlTaCzZNqZOxcDSjyOQPcbAHGttL5STqcYFJR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Contrary to other architectures currently supported by nolibc,
hexagon can only be built with clang.
Prepare run-tests.sh to allow for this.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/run-tests.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index dc0b1649c641..5732b956ead9 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -132,6 +132,12 @@ crosstool_abi() {
 	esac
 }
 
+need_gcc() {
+	case "$1" in
+	*) echo "1";;
+	esac
+}
+
 download_crosstool() {
 	arch="$(crosstool_arch "$1")"
 	abi="$(crosstool_abi "$1")"
@@ -164,14 +170,18 @@ test_arch() {
 	arch=$1
 	ct_arch=$(crosstool_arch "$arch")
 	ct_abi=$(crosstool_abi "$1")
+	gcc="$(need_gcc "$1")"
+	cross_compile=
 
-	if [ ! -d "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/." ]; then
+	if [ -n "$gcc" ] && [ ! -d "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/." ]; then
 		echo "No toolchain found in ${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}."
 		echo "Did you install the toolchains or set the correct arch ? Rerun with -h for help."
 		return 1
 	fi
 
-	cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
+	if [ -n "$gcc" ]; then
+		cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
+	fi
 	build_dir="${build_location}/${arch}"
 	if [ "$werror" -ne 0 ]; then
 		CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror -Wl,--fatal-warnings"

-- 
2.55.0

