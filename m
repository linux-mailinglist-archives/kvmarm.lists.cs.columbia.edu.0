Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F2A724C135D
	for <lists+kvmarm@lfdr.de>; Wed, 23 Feb 2022 13:57:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 888474C505;
	Wed, 23 Feb 2022 07:57:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nqtnSgsmtM8C; Wed, 23 Feb 2022 07:57:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C7B264C4ED;
	Wed, 23 Feb 2022 07:57:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 51FEC4C4E7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Feb 2022 07:57:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eBzFTKRxtrOS for <kvmarm@lists.cs.columbia.edu>;
 Wed, 23 Feb 2022 07:57:17 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CBE954C3CD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Feb 2022 07:57:16 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE825139F;
 Wed, 23 Feb 2022 04:57:15 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA8E3F70D;
 Wed, 23 Feb 2022 04:57:14 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: pbonzini@redhat.com, thuth@redhat.com, drjones@redhat.com,
 varad.gautam@suse.com, zixuanwang@google.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests PATCH v2 1/3] configure: Fix whitespaces for the
 --gen-se-header help text
Date: Wed, 23 Feb 2022 12:55:35 +0000
Message-Id: <20220223125537.41529-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223125537.41529-1-alexandru.elisei@arm.com>
References: <20220223125537.41529-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Replace some of the tabs with spaces to display the help text for the
--gen-se-header option like this:

    --gen-se-header=GEN_SE_HEADER
                           Provide an executable to generate a PV header
                           requires --host-key-document. (s390x-snippets only)

instead of:

    --gen-se-header=GEN_SE_HEADER
                           Provide an executable to generate a PV header
   requires --host-key-document. (s390x-snippets only)

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 2d9c3e051103..0ac9c85502ff 100755
--- a/configure
+++ b/configure
@@ -58,7 +58,7 @@ usage() {
 	                           a PVM image with 'genprotimg' (s390x only)
 	    --gen-se-header=GEN_SE_HEADER
 	                           Provide an executable to generate a PV header
-				   requires --host-key-document. (s390x-snippets only)
+	                           requires --host-key-document. (s390x-snippets only)
 	    --page-size=PAGE_SIZE
 	                           Specify the page size (translation granule) (4k, 16k or
 	                           64k, default is 64k, arm64 only)
-- 
2.35.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
