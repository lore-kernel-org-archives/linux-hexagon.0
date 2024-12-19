Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A538F9C;
	Thu, 19 Dec 2024 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734597246; cv=none; b=pRIF8GSY1qRoVHkWsyXRyKFhaIl7BegqSGas5okZgMAf7hdmJhw/j5qYiEAQ5ROSvG0XKkQqAzqLo+/rc6BWel26KdIBbsAuBFmrhMlIk0c5BFXRpWQPzEMEVXt/kXgt4kA0hVbJKF5iFZS4NkiOvYkZQ91It5T2Dm3UH9E4M48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734597246; c=relaxed/simple;
	bh=QbbGdoHztjxtZpBAK+NNRsPFwDUYwkSh0nDASnOo8II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TyxKw1ZwqeZP3ix53MVaNAyX528tLEbiBqudnQIbCQunshh/uPIhJADls7kIk/r6bZjjrTnlgBiQqYEshfC5nYhvsVjpYJjw026fp8+w3QKQWtZb18GHDQHblFQqBq5etiwx6bJp98q0e6SanCU7Aip38sTuuVbwShnjuusNSbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id D4B9C5F880;
	Thu, 19 Dec 2024 09:34:00 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Brian Cain <bcain@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org
Subject: [PATCH] hexagon: make arch_spin_trylock() return signed int
Date: Thu, 19 Dec 2024 09:34:00 +0100
Message-ID: <8464681.T7Z3S40VBb@devpool47.emlix.com>
Organization: emlix GmbH
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

In contrast to all other architectures this was using an unsigned int while=
 the
variable used to hold the return value inside the function is signed as wel=
l.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
Not tested in any way, but what could possibly go wrong when fiddling with =
low
level locking? ;)

 arch/hexagon/include/asm/spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/spinlock.h b/arch/hexagon/include/asm=
/spinlock.h
index ef103b73bec8..4394b660a12d 100644
=2D-- a/arch/hexagon/include/asm/spinlock.h
+++ b/arch/hexagon/include/asm/spinlock.h
@@ -133,7 +133,7 @@ static inline void arch_spin_unlock(arch_spinlock_t *lo=
ck)
 	lock->lock =3D 0;
 }
=20
=2Dstatic inline unsigned int arch_spin_trylock(arch_spinlock_t *lock)
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
 {
 	int temp;
 	__asm__ __volatile__(
=2D-=20
2.47.1


=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner


