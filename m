Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 11784333259
	for <lists+kvmarm@lfdr.de>; Wed, 10 Mar 2021 01:30:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B94744B5A7;
	Tue,  9 Mar 2021 19:30:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lor8FKVy0bJz; Tue,  9 Mar 2021 19:30:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F186C4B5D7;
	Tue,  9 Mar 2021 19:30:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ECB304B5B2
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 19:30:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WcPEhkvzFuNw for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Mar 2021 19:30:45 -0500 (EST)
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com
 [209.85.161.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DFF174B39A
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 19:30:44 -0500 (EST)
Received: by mail-oo1-f73.google.com with SMTP id e21so7797993oow.18
 for <kvmarm@lists.cs.columbia.edu>; Tue, 09 Mar 2021 16:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=yK9iTxY4SPYbSSesaQoUo2q8UFyrEaYR8MwQ1IPWqYo=;
 b=rfPkmtLrdMMpGWrKUsoZrxSRse5qNsSvVuH/ikfb+KgmDu+7xZIAfNt3HpkpEZ97Az
 zarNFgesGm3PBWe9L+mczl93U732Ye93g+WDGdbRfWuWXNyzVXqWHfiY/cIbjAbmSvnn
 qj8XR13VP7p0Bd1mXfnPXjd8hkcW7rWCwxqMvFG5ZgpsriYl31doDwniGQN2KAZPgHhW
 vxlB4aNj0kDNyTlpdssb2f1iJVPLzBRV0BhxBl6fV30cgxVs3P6ZTphJCo9AJxEKWhqT
 q3oeEXUht4UienfFOrO/VUVMSHSZgd4O88fKVNlhlh4oqoZF6cpqmPjFW81N8l5UmUnd
 UQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=yK9iTxY4SPYbSSesaQoUo2q8UFyrEaYR8MwQ1IPWqYo=;
 b=S7L9aME5fgxK6f6Czxq3fQUDfdxj63fpJnnzljFS9SyizSSe83jOKxNc9SbzU01N8g
 2Df3lCZDmQI951GTrjD8uRAVQtibbeLBh6dk3jYXs38A9om2fgnrJrfCAGaqaDAFZBfd
 GckVk/KK7oKKjyCTPH67PquxW3jo12U1x+PlmkHybmH0IUXJ2lQ15qMreYhaTT+XDi+C
 WvkQ1w+aKaEJ/w60ygBMCgQTDhXzFi5/uAThB2w+bgEvIfHn1Pn466dekjRGLpOhBdNQ
 t0WDkG3GM50Z8w2TWnRbcOMueyyz8VyWlp9cEBSfqcrq4rBuNPxWrnGFIe8TPBP9H419
 FOEg==
X-Gm-Message-State: AOAM530Cy6tLvoiB0AqmResRsRBEyxOyjYjFqpvHtWhxvkPBdp8HDgVV
 Ro9WXZwR7+Kp57uEaN4Mk1K5CMiH7/KJBYTZlQ==
X-Google-Smtp-Source: ABdhPJzrzyemlWc6uAKn+Q/tSsI1AAuaRP7yS778qtLKkneKHFCrPC7TFQ37cF1P4tNWDHS1FdAWFVDzeqEE0qejsg==
X-Received: from jingzhangos.c.googlers.com
 ([fda3:e722:ac3:10:2b:ff92:c0a8:513])
 (user=jingzhangos job=sendgmr) by 2002:a9d:1c7:: with SMTP id
 e65mr592890ote.259.1615336244140; Tue, 09 Mar 2021 16:30:44 -0800 (PST)
Date: Wed, 10 Mar 2021 00:30:22 +0000
In-Reply-To: <20210310003024.2026253-1-jingzhangos@google.com>
Message-Id: <20210310003024.2026253-3-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210310003024.2026253-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [RFC PATCH 2/4] KVM: stats: Define APIs for aggregated stats
 retrieval in binary format
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVM ARM <kvmarm@lists.cs.columbia.edu>, 
 Linux MIPS <linux-mips@vger.kernel.org>, KVM PPC <kvm-ppc@vger.kernel.org>, 
 Linux S390 <linux-s390@vger.kernel.org>, 
 Linux kselftest <linux-kselftest@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Mackerras <paulus@ozlabs.org>, 
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Sean Christopherson <seanjc@google.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>, 
 Peter Shier <pshier@google.com>, Oliver Upton <oupton@google.com>, 
 David Rientjes <rientjes@google.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>
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

Define ioctl commands for VM/vCPU aggregated statistics data retrieval
in binary format and update corresponding API documentation.

The capability and ioctl are not enabled for now.
No functional change intended.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 Documentation/virt/kvm/api.rst | 79 ++++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h       |  1 -
 include/uapi/linux/kvm.h       | 60 ++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1a2b5210cdbf..aa4b5270c966 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4938,6 +4938,76 @@ see KVM_XEN_VCPU_SET_ATTR above.
 The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
 with the KVM_XEN_VCPU_GET_ATTR ioctl.
 
+4.131 KVM_STATS_GET_INFO
+------------------------
+
+:Capability: KVM_CAP_STATS_BINARY_FORM
+:Architectures: all
+:Type: vm ioctl, vcpu ioctl
+:Parameters: struct kvm_stats_info (out)
+:Returns: 0 on success, < 0 on error
+
+::
+
+  struct kvm_stats_info {
+        __u32 num_stats;
+  };
+
+This ioctl is used to get the information about VM or vCPU statistics data.
+The number of statistics data would be returned in field num_stats in
+struct kvm_stats_info. This ioctl only needs to be called once on running
+VMs on the same architecture.
+
+4.132 KVM_STATS_GET_NAMES
+-------------------------
+
+:Capability: KVM_CAP_STATS_BINARY_FORM
+:Architectures: all
+:Type: vm ioctl, vcpu ioctl
+:Parameters: struct kvm_stats_names (in/out)
+:Returns: 0 on success, < 0 on error
+
+::
+
+  #define KVM_STATS_NAME_LEN		32
+  struct kvm_stats_names {
+	__u32 size;
+	__u8  names[0];
+  };
+
+This ioctl is used to get the string names of all the statistics data for VM
+or vCPU. Users must use KVM_STATS_GET_INFO to find the number of statistics.
+They must allocate a buffer of the size num_stats * KVM_STATS_NAME_LEN
+immediately following struct kvm_stats_names. The size field of kvm_stats_name
+must contain the buffer size as an input.
+The buffer can be treated like a string array, each name string is null-padded
+to a size of KVM_STATS_NAME_LEN;
+This ioclt only needs to be called once on running VMs on the same architecture.
+
+4.133 KVM_STATS_GET_DATA
+-------------------------
+
+:Capability: KVM_CAP_STATS_BINARY_FORM
+:Architectures: all
+:Type: vm ioctl, vcpu ioctl
+:Parameters: struct kvm_stats_data (in/out)
+:Returns: 0 on success, < 0 on error
+
+::
+
+  struct kvm_stats_data {
+	__u32 size;
+	__u64 data[0];
+  };
+
+This ioctl is used to get the aggregated statistics data for VM or vCPU.
+Users must use KVM_STATS_GET_INFO to find the number of statistics.
+They must allocate a buffer of the appropriate size num_stats * sizeof(data[0])
+immediately following struct kvm_stats_data. The size field of kvm_stats_data
+must contain the buffer size as an input.
+The data buffer 1-1 maps to name strings buffer in sequential order.
+This ioctl is usually called periodically to pull statistics data.
+
 5. The kvm_run structure
 ========================
 
@@ -6721,3 +6791,12 @@ vcpu_info is set.
 The KVM_XEN_HVM_CONFIG_RUNSTATE flag indicates that the runstate-related
 features KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADDR/_CURRENT/_DATA/_ADJUST are
 supported by the KVM_XEN_VCPU_SET_ATTR/KVM_XEN_VCPU_GET_ATTR ioctls.
+
+8.31 KVM_CAP_STATS_BINARY_FORM
+------------------------------
+
+:Architectures: all
+
+This capability indicates that KVM supports retrieving aggregated statistics
+data in binary format with corresponding VM/VCPU ioctl KVM_STATS_GET_INFO,
+KVM_STATS_GET_NAMES and KVM_STATS_GET_DATA.
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1ea297458306..f2dabf457717 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1164,7 +1164,6 @@ static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
 
 #define VM_STAT_COUNT		(sizeof(struct kvm_vm_stat)/sizeof(ulong))
 #define VCPU_STAT_COUNT		(sizeof(struct kvm_vcpu_stat)/sizeof(u64))
-#define KVM_STATS_NAME_LEN	32
 
 /* Make sure it is synced with fields in struct kvm_vm_stat. */
 extern const char kvm_vm_stat_strings[][KVM_STATS_NAME_LEN];
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f6afee209620..ad185d4c5e42 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1078,6 +1078,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_DIRTY_LOG_RING 192
 #define KVM_CAP_X86_BUS_LOCK_EXIT 193
 #define KVM_CAP_PPC_DAWR1 194
+#define KVM_CAP_STATS_BINARY_FORM 195
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1853,4 +1854,63 @@ struct kvm_dirty_gfn {
 #define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
 #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
 
+/* Available with KVM_CAP_STATS_BINARY_FORM */
+
+#define KVM_STATS_NAME_LEN		32
+
+/**
+ * struct kvm_stats_info - statistics information
+ *
+ * Used as parameter for ioctl %KVM_STATS_GET_INFO.
+ *
+ * @num_stats: On return, the number of statistics data of vm or vcpu.
+ *
+ */
+struct kvm_stats_info {
+	__u32 num_stats;
+};
+
+/**
+ * struct kvm_stats_names - string list of statistics names
+ *
+ * Used as parameter for ioctl %KVM_STATS_GET_NAMES.
+ *
+ * @size: Input from user, indicating the size of buffer after the struture.
+ * @names: Buffer of name string list for vm or vcpu. Each string is
+ *	null-padded to a size of %KVM_STATS_NAME_LEN.
+ *
+ * Users must use %KVM_STATS_GET_INFO to find the number of
+ * statistics. They must allocate a buffer of the appropriate
+ * size (>= &struct kvm_stats_info @num_stats * %KVM_STATS_NAME_LEN)
+ * immediately following this struture.
+ */
+struct kvm_stats_names {
+	__u32 size;
+	__u8  names[0];
+};
+
+/**
+ * struct kvm_stats_data - statistics data array
+ *
+ * Used as parameter for ioctl %KVM_STATS_GET_DATA.
+ *
+ * @size: Input from user, indicating the size of buffer after the struture.
+ * @data: Buffer of statistics data for vm or vcpu.
+ *
+ * Users must use %KVM_STATS_GET_INFO to find the number of
+ * statistics. They must allocate a buffer of the appropriate
+ * size (>= &struct kvm_stats_info @num_stats * sizeof(@data[0])
+ * immediately following this structure.
+ * &struct kvm_stats_names @names 1-1 maps to &structkvm_stats_data
+ * @data in sequential order.
+ */
+struct kvm_stats_data {
+	__u32 size;
+	__u64 data[0];
+};
+
+#define KVM_STATS_GET_INFO		_IOR(KVMIO, 0xcc, struct kvm_stats_info)
+#define KVM_STATS_GET_NAMES		_IOR(KVMIO, 0xcd, struct kvm_stats_names)
+#define KVM_STATS_GET_DATA		_IOR(KVMIO, 0xce, struct kvm_stats_data)
+
 #endif /* __LINUX_KVM_H */
-- 
2.30.1.766.gb4fecdf3b7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
